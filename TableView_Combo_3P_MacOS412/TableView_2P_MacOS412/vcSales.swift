//
//  vcSales.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 18/05/23.
//

import Cocoa

//TODO
//Add/Substract units from products

class vcSales: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var sales: [Sale] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var purchases: [Purchase] = [];
    var userid:Int = 0;
    var saleid:Int = 0;
    var productid:Int = 0;
    var purchaseid:Int = 0;
    var flag: Bool = false;
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSaleID.integerValue = sales.count
        txtSaleID.isEnabled = false
        txtProductName.isEnabled = false
        txtUnits.isEnabled = false;
        txtSubtotal.isEnabled = false
        txtIVA.isEnabled = false
        txtTotal.isEnabled = false
        btnAdd.isHidden = flag
        btnModify.isHidden = !flag
        
        if (flag) {
            txtSaleID.integerValue = sales[saleid].id;
            txtClientID.integerValue = sales[saleid].clientid;
            txtProductID.integerValue = sales[saleid].productid;
            txtProductName.stringValue = sales[saleid].productname;
            txtUnits.integerValue = sales[saleid].units;
            txtSubtotal.doubleValue = sales[saleid].subtotal;
            txtIVA.doubleValue = sales[saleid].iva;
            txtTotal.doubleValue = sales[saleid].total;
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
    
    @IBOutlet weak var txtSaleID: NSTextField!
    @IBOutlet weak var txtClientID: NSTextField!
    @IBOutlet weak var txtProductID: NSTextField!
    @IBOutlet weak var txtProductName: NSTextField!
    @IBOutlet weak var txtUnits: NSTextField!
    @IBOutlet weak var txtSubtotal: NSTextField!
    @IBOutlet weak var txtIVA: NSTextField!
    @IBOutlet weak var txtTotal: NSTextField!
    @IBOutlet weak var btnAdd: NSButton!
    @IBOutlet weak var btnModify: NSButton!
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeSellerFromSales") {
            let destinationVC = segue.destinationController as! vcWelcomeSeller;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goQuerySalesFromSales") {
            let destinationVC = segue.destinationController as! vcQuerySales;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
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
    
    @IBAction func unitsEntered(_ sender: NSTextField) {
        if (checkForEnoughUnits()) {
            txtSubtotal.doubleValue = products[productid].price * txtUnits.doubleValue;
            txtIVA.stringValue = "16%"
            txtTotal.doubleValue = txtSubtotal.doubleValue * 1.16
        } else {
            print("Product does not have enough units.");
        }
    }
    
    @IBAction func add(_ sender: NSButton) {
        if(areFieldsCompleted() && isFormatCorrect()){
            if (checkForExistingClient()) {
                let sale = Sale.getInstance(txtClientID.integerValue, txtProductID.integerValue, products[productid].name, txtUnits.integerValue, txtSubtotal.doubleValue);
                PurchaseController.shared.purchases[purchaseid].units -= sale.units;
                if (flag) {
                    PurchaseController.shared.purchases[purchaseid].units += sales[saleid].units;
                    SaleController.shared.modifySale(saleid, sale);
                    print("Venta con id:" + String(saleid) + " fue modificada con exito");
                    callModal("Venta modificada");
                } else {
                    SaleController.shared.addSale(sale);
                    callModal("Venta agregada");
                    txtSaleID.integerValue = SaleController.shared.sales.count
                }
            } else {
                print("Client does not exist");
            }
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (flag) {
            identifier = "goQuerySalesFromSales"
        } else {
            identifier = "goWelcomeSellerFromSales"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    func areFieldsCompleted()  -> Bool {
        let fields: [(textField: NSTextField, errorMessage: String)] = [
            (txtSaleID, "Sale's ID is missing."),
            (txtClientID, "Clients's ID is missing."),
            (txtProductID, "Product's ID is missing."),
            (txtProductName, "Product's name is missing."),
            (txtUnits, "Quantity is missing.")
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
        
        
        let numberFields: [NSTextField] = [txtSaleID, txtClientID, txtProductID, txtUnits]
        
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
    
    func checkForExistingClient() -> Bool {
        for user in users {
            if (user.id == txtClientID.integerValue) {
                if (user.role == "client") {
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

    func checkForEnoughUnits() -> Bool {
        for purchase in purchases {
            if (purchase.productid == txtProductID.integerValue) {
                if (purchase.units >= txtUnits.integerValue) {
                    purchaseid = purchase.id;
                    return true;
                }
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
