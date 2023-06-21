//
//  PurchaseController.swift
//  TableView_2P_MacOS412
//
//  Created by MacOS on 22/05/23.
//

import Foundation

class PurchaseController{
    static var shared = PurchaseController();
    
    @objc dynamic var purchases: [Purchase] = [Purchase.coca, Purchase.pepsi, Purchase.maruchan, Purchase.zucaritas, Purchase.carlos];
    
    func addPurchase(_ purchase:Purchase) {
        print("Purchase added successfully.");
        purchases.append(purchase);
    }
    
    func modifyPurchase(_ id: Int,_ purchase:Purchase) {
        print("Purchase modified succesfully.");
        purchases[id].productid = purchase.productid;
        purchases[id].productname = purchase.productname;
        purchases[id].units = purchase.units;
        purchases[id].buyerid = purchase.buyerid;
        purchases[id].buyername = purchase.buyername;
    }

    func deletePurchase(_ id:Int) {
        print("Purchase deleted succesfully.");
        purchases.remove(at: id);
    }
}
