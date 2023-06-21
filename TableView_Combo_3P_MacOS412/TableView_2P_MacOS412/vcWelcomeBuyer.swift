//
//  vcWelcomeBuyer.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 17/05/23.
//

import Cocoa

class vcWelcomeBuyer: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var purchases: [Purchase] = [];
    var userid:Int = 0;
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUser.stringValue = users[userid].name;
        lblRole.stringValue = users[userid].role;
        
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
    
    @IBOutlet weak var lblUser: NSTextField!
    @IBOutlet weak var lblRole: NSTextField!
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goLoginFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcLogin;
            destinationVC.users = users;
            destinationVC.id = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goProductsFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcProducts;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goQueryProductsFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcQueryProducts;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goPurchasesFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcPurchases;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goQueryPurchasesFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcQueryPurchases;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goAdminFromWelcomeBuyer") {
            let destinationVC = segue.destinationController as! vcAdmin;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
    }
    
    @IBAction func redirectAltaProducto(_ sender: NSButton) {
        performSegue(withIdentifier: "goProductsFromWelcomeBuyer", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func redirectAltaCompra(_ sender: NSButton) {
        performSegue(withIdentifier: "goPurchasesFromWelcomeBuyer", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func redirectQueryProducto(_ sender: NSButton) {
        performSegue(withIdentifier: "goQueryProductsFromWelcomeBuyer", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func redirectQueryCompra(_ sender: NSButton) {
        performSegue(withIdentifier: "goQueryPurchasesFromWelcomeBuyer", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (users[userid].role == "admin") {
            identifier = "goAdminFromWelcomeBuyer"
        } else {
            identifier = "goLoginFromWelcomeBuyer"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
