//
//  SaleController.swift
//  TableView_2P_MacOS412
//
//  Created by ISSC_412_2023 on 18/05/23.
//

import Foundation

class SaleController{
    static var shared = SaleController();
    
    @objc dynamic var sales: [Sale] = [Sale.coca, Sale.pepsi, Sale.maruchan, Sale.zucaritas, Sale.carlos];
    
    func addSale(_ sale:Sale) {
        print("Sale added successfully.");
        sales.append(sale);
    }
    
    func modifySale(_ id: Int,_ sale:Sale) {
        print("Sale modified succesfully.");
        sales[id].clientid = sale.clientid;
        sales[id].productid = sale.productid;
        sales[id].productname = sale.productname;
        sales[id].units = sale.units;
        sales[id].subtotal = sale.subtotal;
        sales[id].total = sale.subtotal + sale.subtotal * sale.iva
    }
    
    func deleteSale(_ id:Int) {
        print("Sale deleted succesfully.");
        sales.remove(at: id);
    }
}
