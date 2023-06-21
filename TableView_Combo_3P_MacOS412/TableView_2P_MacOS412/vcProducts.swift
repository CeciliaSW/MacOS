//
//  vcProducts.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 20/05/23.
//

import Cocoa

class vcProducts: NSViewController {
    
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
        txtProductID.integerValue = purchases.count
        txtProductID.isEnabled = false
        btnAdd.isHidden = flag
        btnModify.isHidden = !flag
        
        if (flag) {
            txtProductID.integerValue = products[productid].id;
            txtProductName.stringValue = products[productid].name;
            txtProductDescription.stringValue = products[productid].details;
            txtProductPrice.doubleValue = products[productid].price;
            txtProductCost.doubleValue = products[productid].cost;
            txtProductType.stringValue = products[productid].category;
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
    
    @IBOutlet weak var txtProductID: NSTextField!
    @IBOutlet weak var txtProductName: NSTextField!
    @IBOutlet weak var txtProductDescription: NSTextField!
    @IBOutlet weak var txtProductPrice: NSTextField!
    @IBOutlet weak var txtProductCost: NSTextField!
    @IBOutlet weak var txtProductType: NSTextField!
    @IBOutlet weak var btnAdd: NSButton!
    @IBOutlet weak var btnModify: NSButton!
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeBuyerFromProducts") {
            let destinationVC = segue.destinationController as! vcWelcomeBuyer;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goQueryProductsFromProducts") {
            let destinationVC = segue.destinationController as! vcQueryProducts;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = purchases;
        }
    }
    
    @IBAction func add(_ sender: NSButton) {
        if(areFieldsCompleted() && isFormatCorrect()){
            let product = Product.getInstance(txtProductName.stringValue, txtProductDescription.stringValue, txtProductPrice.doubleValue, txtProductCost.doubleValue, txtProductType.stringValue);
                if (flag) {
                    ProductController.shared.modifyProduct(productid, product);
                    print("Producto con id:" + String(productid) + " fue modificado con exito");
                    callModal("Producto modificado");
                } else {
                    ProductController.shared.addProduct(product);
                    callModal("Producto agregado");
                    txtProductID.integerValue = ProductController.shared.products.count
                }
        }
}
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (flag) {
            identifier = "goQueryProductsFromProducts"
        } else {
            identifier = "goWelcomeBuyerFromProducts"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    func areFieldsCompleted()  -> Bool{
        let fields: [(textField: NSTextField, errorMessage: String)] = [
            (txtProductName, "Product's name is missing."),
            (txtProductDescription, "Description is missing."),
            (txtProductPrice, "Product's price is missing."),
            (txtProductCost, "Product's cost is missing."),
            (txtProductType, "Type is missing."),
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
        let fields: [NSTextField] = [txtProductName, txtProductDescription, txtProductType]
        
        for field in fields {
            if textFieldHasSpecialCharactersAndNumbers(field) {
                print("No numbers or special characters are accepted on this field.")
                return false;
            }
            
            if !TextfieldHasValidName(field){
                return false;
            }
        }
        
        let numberFields: [NSTextField] = [txtProductPrice, txtProductCost]
        
        for numberField in numberFields {
            if(containsNonNumericCharacters(numberField)) {
                print("Only numbers and points are accepted on this field.")
                return false;
            }
        }
        
        return true;
    }
    
    func textFieldHasSpecialCharactersAndNumbers(_ textField: NSTextField) -> Bool {
        let specialCharAndNumberRegex = ".*[^A-Za-z0-9]áéíóúÁÉÍÓÚäëïöüÄËÏÖÜ]+.*|.*\\d+.*"
        let specialCharAndNumberPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharAndNumberRegex)
        let containsSpecialCharAndNumber = specialCharAndNumberPredicate.evaluate(with: textField.stringValue)
        let containsSpace = textField.stringValue.contains(" ")
        
        return containsSpecialCharAndNumber && !containsSpace
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
        let nonNumericRegex = "^[0-9]+(\\.[0-9]+)?[^.]?$"
        let text = textField.stringValue
        
        let regex = try! NSRegularExpression(pattern: nonNumericRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        return regex.firstMatch(in: text, options: [], range: range) == nil
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
