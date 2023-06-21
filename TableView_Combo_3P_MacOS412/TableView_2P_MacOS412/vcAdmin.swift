//
//  vcAdmin.swift
//  TableView_2P_MacOS412
//
//  Created by MacOS on 22/05/23.
//

import Cocoa

class vcAdmin: NSViewController {
    @objc dynamic var users: [User] = [];
    var userid:Int = 0;
    
    @IBOutlet weak var lblUser: NSTextField!
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUser.stringValue = users[userid].name;
    
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
        if (segue.identifier == "goWelcomeFromAdmin") {
            let destinationVC = segue.destinationController as! vcWelcome;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
        
        if (segue.identifier == "goBuyerFromAdmin") {
            let destinationVC = segue.destinationController as! vcWelcomeBuyer;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        
        if (segue.identifier == "goSellerFromAdmin") {
            let destinationVC = segue.destinationController as! vcWelcomeSeller;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        if (segue.identifier == "goClientFromAdmin") {
            let destinationVC = segue.destinationController as! vcWelcomeClient;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.orders = SaleController.shared.sales;
        }
    }
    
    @IBAction func goBuyer(_sender: NSButton){
        performSegue(withIdentifier: "goBuyerFromAdmin", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func goSeller(_sender: NSButton){
        performSegue(withIdentifier: "goSellerFromAdmin", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func goClient(_ sender: NSButton) {
        performSegue(withIdentifier: "goClientFromAdmin", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
        
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goWelcomeFromAdmin", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
