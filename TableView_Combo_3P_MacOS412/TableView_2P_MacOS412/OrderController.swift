//
//  OrderController.swift
//  TableView_2P_MacOS412
//
//  Created by MacOS on 22/05/23.
//

import Foundation

class OrderController{
//does not work, needs both clientid and saleid, consult with teacher
    static var shared = OrderController();
    
    @objc dynamic var orders: [Order] = [];
    
    func addOrder(_ order:Order) {
        print("Order added successfully.");
        orders.append(order);
    }
    
    func modifyOrder(_ id: Int,_ order:Order) {
        print("Order modified succesfully.");
        orders[id].productid = order.productid;
        orders[id].productdetails = order.productdetails;
    }

    func deleteOrder(_ id:Int) {
        print("Order deleted succesfully.");
        orders.remove(at: id);
    }
}
