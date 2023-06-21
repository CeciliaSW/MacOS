import Foundation
var orderid = 0;

class Order: NSObject {
    @objc dynamic var id:Int;
    @objc dynamic var productid:Int;
    @objc dynamic var productdetails:String;
  
   
    
    private init(_ productid: Int,_ productdetails: String) {
        self.id = orderid
        self.productid = productid
        self.productdetails = productdetails
        orderid += 1
    }
    
    static func getInstance(_ productid: Int,_ productdetails: String) -> Order {
        return Order(productid, productdetails);
    }
}
