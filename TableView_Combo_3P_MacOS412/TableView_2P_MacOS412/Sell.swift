import Foundation
var saleID = 0;
var clientID = 0;
var ProductID = 0;


class Sale: NSObject {
    @objc dynamic var id:Int;
    @objc dynamic var infoproduct:String;
    @objc dynamic var amountSale:Int;
    @objc dynamic var subtotal:Decimal;
    @objc dynamic var iva:Decimal;
    @objc dynamic var total:Decimal;
   
    
    private init(_ infoproduct: String,_ amount: Int,_ subtotal: Decimal,_ iva : Decimal,_ total: Decimal) {
        self.id = saleID
        self.id = clientID
        self.id = ProductID
        self.infoproduct = infoproduct
        self.amountSale = amount
        self.subtotal = subtotal
        self.iva = iva
        self.total = total
        
        saleID += 1
        clientID += 1
        ProductID += 1
    }
    
    static func getInstance(_ infoproduct: String,_ amountSale: Int,_ subtotal: Decimal,_ iva : Decimal,_ total: Decimal) -> Sale {
        return Sale(infoproduct, amountSale, subtotal, iva,  total);
    }
    
    static var admin = Sale("Good",5,550.50,560.20,560.20);
}
