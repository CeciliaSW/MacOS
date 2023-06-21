//
//  vcWelcomeClient.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 17/05/23.
//

import Cocoa

class vcWelcomeClient: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var orders: [Sale] = [];

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
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goLoginFromWelcomeClient") {
            let destinationVC = segue.destinationController as! vcLogin;
            destinationVC.users = users;
            destinationVC.id = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        if (segue.identifier == "goQueryClientFromWelcomeClient") {
            let destinationVC = segue.destinationController as! vcOrders;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.orders = orders;
        }
        if (segue.identifier == "goAdminFromWelcomeClient") {
            let destinationVC = segue.destinationController as! vcAdmin;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
    }
    
    @IBOutlet weak var lblUser: NSTextField!
    @IBOutlet weak var lblRole: NSTextField!
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (users[userid].role == "admin") {
            identifier = "goAdminFromWelcomeClient"
        } else {
            identifier = "goLoginFromWelcomeClient"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    
    @IBAction func redirectQueryOrders(_ sender: NSButton) {
        performSegue(withIdentifier: "goQueryClientFromWelcomeClient", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
