//
//  vcQueryPurchases.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 20/05/23.
//

import Cocoa

class vcQueryPurchases: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var sales: [Sale] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var purchases: [Purchase] = [];
    var userid:Int = 0;
    
    var deletedPurchase: String = "";
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
        if (segue.identifier == "goWelcomeBuyerFromQueryPurchases") {
            let destinationVC = segue.destinationController as! vcWelcomeBuyer;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        if (segue.identifier == "goPurchasesFromQueryPurchases") {
            let destinationVC = segue.destinationController as! vcPurchases;
            destinationVC.flag = true;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = PurchaseController.shared.purchases;
            destinationVC.purchaseid = txtID.integerValue;
        }
    }
    
    @IBAction func btnModify(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingPurchase()) {
                    performSegue(withIdentifier: "goPurchasesFromQueryPurchases", sender: self);
                    self.view.window?.windowController?.close();
                    dismiss(self);
                }
            } else {
                print("ID textfield must be filled to modify a purchase.");
            }
        } else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    @IBAction func btnDelete(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingPurchase()) {
                    PurchaseController.shared.deletePurchase(txtID.integerValue);
                    print("Compra con id: " + txtID.stringValue + " fue eliminada con exito");
                    callModal("Compra eliminada");
                }
            } else {
                print("ID textfield must be filled to delete a purchase.");
            }
        } else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goWelcomeBuyerFromQueryPurchases", sender: self);
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
    
    func checkForExistingPurchase() -> Bool {
        for purchase in purchases {
            if (purchase.id == txtID.integerValue) {
                print(purchase.id);
                return true;
            }
        }
        print("Purchase with this ID does not exist.");
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

