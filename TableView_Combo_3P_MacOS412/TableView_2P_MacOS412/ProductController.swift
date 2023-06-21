//
//  ProductController.swift
//  TableView_2P_MacOS412
//
//  Created by MacOS on 22/05/23.
//

import Foundation

class ProductController{
    static var shared = ProductController();
    
    @objc dynamic var products: [Product] = [Product.coca, Product.pepsi, Product.maruchan, Product.zucaritas, Product.carlos];
    
    func addProduct(_ product:Product) {
        print("Product added successfully.");
        products.append(product);
    }
    
    func modifyProduct(_ id: Int,_ product:Product) {
        print("Product modified succesfully.");
        products[id].name = product.name;
        products[id].details = product.details;
        products[id].price = product.price;
        products[id].cost = product.cost;
        products[id].category = product.category;
    }

    func deleteProduct(_ id:Int) {
        print("Product deleted succesfully.");
        products.remove(at: id);
    }
}
