//
//  vcQuerySales.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 18/05/23.
//

import Cocoa

//TODO
//Add units from products when sale deleted

class vcQuerySales: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var sales: [Sale] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var purchases: [Purchase] = [];
    var userid:Int = 0;
    
    var deletedSale: String = "";
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeSellerFromQuerySales") {
            let destinationVC = segue.destinationController as! vcWelcomeSeller;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goSalesFromQuerySales") {
            let destinationVC = segue.destinationController as! vcSales;
            destinationVC.flag = true;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
            destinationVC.saleid = txtID.integerValue;
        }
    }
    
    @IBAction func btnModify(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingSale()) {
                    performSegue(withIdentifier: "goSalesFromQuerySales", sender: self);
                    self.view.window?.windowController?.close();
                    dismiss(self);
                }
            } else {
                print("ID textfield must be filled to modify a sale.");
            }
        } else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    @IBAction func btnDelete(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingSale()) {
                    PurchaseController.shared.purchases[findPurchase()].units += sales[txtID.integerValue].units;
                    SaleController.shared.deleteSale(txtID.integerValue);
                    print("Venta con id: " + txtID.stringValue + " fue eliminada con exito");
                    callModal("Venta eliminada");
                }
            } else {
                print("ID textfield must be filled to delete a sale.");
            }
        } else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goWelcomeSellerFromQuerySales", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    func containsNonNumericCharacters(_ textField: NSTextField) -> Bool {
        let nonNumericRegex = "[^0-9]"
        let text = textField.stringValue
        
        let regex = try! NSRegularExpression(pattern: nonNumericRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
    
    func checkForID() -> Bool {
        if (txtID.stringValue == "") {
            return false
        } else {
            return true
        }
    }
    
    func checkForExistingSale() -> Bool {
        for sale in sales {
            if (sale.id == txtID.integerValue) {
                print(sale.id);
                return true;
            }
        }
        print("Sale with this ID does not exist.");
        return false;
    }
    
    func findPurchase() -> Int {
        for purchase in purchases {
            if (purchase.productid == sales[txtID.integerValue].productid) {
                return purchase.id;
            }
        }
        return 0;
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
