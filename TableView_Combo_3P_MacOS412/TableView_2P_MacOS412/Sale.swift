import Foundation
var saleid = 0;

class Sale: NSObject {
    @objc dynamic var id:Int;
    @objc dynamic var clientid:Int;
    @objc dynamic var productid:Int;
    @objc dynamic var productname:String;
    @objc dynamic var units:Int;
    @objc dynamic var subtotal:Double;
    @objc dynamic var iva:Double;
    @objc dynamic var total:Double;
    @objc dynamic var clientname:String;
    
    private init(_ clientid: Int,_ productid: Int,_ productname: String,_ units: Int,_ subtotal: Double) {
        self.id = saleid
        self.clientid = clientid
        self.productid = productid
        self.productname = productname
        self.units = units
        self.subtotal = subtotal
        self.iva = 0.16
        self.total = subtotal + subtotal * iva
        self.clientname = LoginController.shared.users[clientid].name;
        saleid += 1
    }
    
    static func getInstance(_ clientid: Int,_ productid: Int,_ productname: String,_ units: Int,_ subtotal: Double) -> Sale {
        return Sale(clientid, productid, productname, units, subtotal);
    }
    
    static var coca = Sale(3, 0, "Coca", 20, 300);
    static var pepsi = Sale(3, 1, "Pepsi", 15, 195);
    static var maruchan = Sale(3, 2, "Maruchan", 10, 120);
    static var zucaritas = Sale(3, 4, "Zucaritas", 16, 150);
    static var carlos = Sale(4, 5, "Carlos V", 19, 130);
}
