//
//  vcWelcomeSeller.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 17/05/23.
//

import Cocoa

class vcWelcomeSeller: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var sales: [Sale] = [];
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
        if (segue.identifier == "goLoginFromWelcomeSeller") {
            let destinationVC = segue.destinationController as! vcLogin;
            destinationVC.users = users;
            destinationVC.id = userid;
            destinationVC.sales = sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goSalesFromWelcomeSeller") {
            let destinationVC = segue.destinationController as! vcSales;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goQuerySalesFromWelcomeSeller") {
            let destinationVC = segue.destinationController as! vcQuerySales;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goAdminFromWelcomeSeller") {
            let destinationVC = segue.destinationController as! vcAdmin;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
    }
    
    @IBAction func redirectAlta(_ sender: NSButton) {
        performSegue(withIdentifier: "goSalesFromWelcomeSeller", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func redirectQuery(_ sender: NSButton) {
        performSegue(withIdentifier: "goQuerySalesFromWelcomeSeller", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (users[userid].role == "admin") {
            identifier = "goAdminFromWelcomeSeller"
        } else {
            identifier = "goLoginFromWelcomeSeller"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
