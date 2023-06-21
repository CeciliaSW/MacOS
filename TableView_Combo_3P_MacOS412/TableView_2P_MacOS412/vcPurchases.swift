//
//  vcPurchases.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 20/05/23.
//

import Cocoa

class vcPurchases: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var purchases: [Purchase] = [];
    var userid:Int = 0;
    var productid:Int = 0;
    var purchaseid:Int = 0;
    var flag: Bool = false;
    var buyername: String = "";
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPurchaseID.integerValue = purchases.count
        txtPurchaseID.isEnabled = false
        txtProductName.isEnabled = false
        txtUnits.isEnabled = false;
        btnAdd.isHidden = flag
        btnModify.isHidden = !flag
        
        if (flag) {
            txtPurchaseID.integerValue = purchases[purchaseid].id;
            txtProductID.integerValue = purchases[purchaseid].productid;
            txtProductName.stringValue = purchases[purchaseid].productname;
            txtUnits.integerValue = purchases[purchaseid].units;
            txtBuyerID.integerValue = purchases[purchaseid].buyerid;
        }
        
        color = users[userid].color;
        image = users[userid].image;
        
        if(users[userid].color != [0.0]){
            view.wantsLayer = true;
            view.layer?.backgroundColor = CGColor(red: color[0], green: color[1], blue: color[2], alpha: color[3]);
        }
        if (users[userid].image != "None"){
            bgImage.image = NSImage(named: image);
        }
    }
    
    @IBOutlet weak var txtPurchaseID: NSTextField!
    @IBOutlet weak var txtProductID: NSTextField!
    @IBOutlet weak var txtProductName: NSTextField!
    @IBOutlet weak var txtUnits: NSTextField!
    @IBOutlet weak var txtBuyerID: NSTextField!
    @IBOutlet weak var btnAdd: NSButton!
    @IBOutlet weak var btnModify: NSButton!
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeBuyerFromPurchases") {
            let destinationVC = segue.destinationController as! vcWelcomeBuyer;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        if (segue.identifier == "goQueryPurchasesFromPurchases") {
            let destinationVC = segue.destinationController as! vcQueryPurchases;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
    }
    
    @IBAction func productIDEntered(_ sender: NSTextField) {
        if (checkForExistingProduct()) {
            txtProductName.stringValue = products[productid].name;
            txtUnits.isEnabled = true;
        } else {
            print("Product does not exist.");
        }
    }
    
    @IBAction func add(_ sender: NSButton) {
        if(areFieldsCompleted() && isFormatCorrect()){
            if (checkForExistingBuyer()) {
                let purchase = Purchase.getInstance(productid, products[productid].name, txtUnits.integerValue, txtBuyerID.integerValue, buyername);
                if (flag) {
                    PurchaseController.shared.modifyPurchase(purchaseid, purchase);
                    print("Compra con id:" + String(purchaseid) + " fue modificada con exito");
                    callModal("Compra modificada");
                } else {
                    PurchaseController.shared.addPurchase(purchase);
                    callModal("Compra agregada");
                    txtPurchaseID.integerValue = PurchaseController.shared.purchases.count
                    purchaseid += 1;
                }
            } else {
                print("Buyer does not exist");
            }
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (flag) {
            identifier = "goQueryPurchasesFromPurchases"
        } else {
            identifier = "goWelcomeBuyerFromPurchases"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    func areFieldsCompleted()  -> Bool{
        let fields: [(textField: NSTextField, errorMessage: String)] = [
            (txtPurchaseID, "Purchase's ID is missing."),
            (txtProductID, "Product's ID is missing."),
            (txtProductName, "Product's name is missing."),
            (txtUnits, "Quantity is missing."),
            (txtBuyerID, "Buyer's ID is missing."),
        ]
        
        for field in fields {
            let textField = field.textField
            let errorMessage = field.errorMessage
            
            if textField.stringValue.isEmpty {
                print(errorMessage)
                return false;
            }
        }
        
        return true;
    }
    
    func isFormatCorrect()  -> Bool{
            if textFieldHasSpecialCharactersAndNumbers(txtProductName) {
                print("No numbers or special characters are accepted on this field.")
                return false;
            }
            
            if !TextfieldHasValidName(txtProductName){
                return false;
            }
        
        
        let numberFields: [NSTextField] = [txtPurchaseID,txtProductID,txtUnits,txtBuyerID]
        
        for numberField in numberFields {
            if(containsNonNumericCharacters(numberField)) {
                print("Only numbers are accepted on this field.")
                return false;
            }
        }
        
        return true;
    }
    
    func textFieldHasSpecialCharactersAndNumbers(_ textField: NSTextField) -> Bool {
        let specialCharAndNumberRegex = ".*[^A-Za-z0-9]+.*|.*\\d+.*"
        let specialCharAndNumberPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharAndNumberRegex)
        return specialCharAndNumberPredicate.evaluate(with: textField.stringValue)
    }

    func TextfieldHasValidName(_ textUser: NSTextField) -> Bool {
        let textfield = textUser.stringValue
        
        if textfield.count < 4 {
            print("Must be at least four characters long");
            return false
        }
        
        return true
    }
    
    func containsNonNumericCharacters(_ textField: NSTextField) -> Bool {
        let nonNumericRegex = "[^0-9]"
        let text = textField.stringValue
        
        let regex = try! NSRegularExpression(pattern: nonNumericRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
    
    func checkForExistingBuyer() -> Bool {
        for user in users {
            if (user.id == txtBuyerID.integerValue) {
                if (user.role == "buyer") {
                    buyername = user.name;
                    return true;
                }
            }
        }
        return false;
    }

    func checkForExistingProduct() -> Bool {
        for product in products {
            if (product.id == txtProductID.integerValue) {
                productid = product.id;
                return true;
            }
        }
        return false;
    }
    
    func callModal(_ action:String){
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        guard let notification = storyboard.instantiateController(withIdentifier: "modal") as? vcModal else {
            return
        }
        
        self.presentAsModalWindow(notification);
        notification.lblAction.stringValue = action;
    }
}
