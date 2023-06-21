import Foundation

var purchaseid = 0;

  class Purchase: NSObject {
      @objc dynamic var id:Int;
      @objc dynamic var productid:Int;
      @objc dynamic var productname:String;
      @objc dynamic var units:Int;
      @objc dynamic var buyerid:Int;
      @objc dynamic var buyername:String;
    
      private init(_ productid:Int, _ productname:String,_ units:Int,_ buyerid:Int,_ buyername: String) {
          self.id = purchaseid;
          self.productid = productid;
          self.productname = productname;
          self.units = units;
          self.buyerid = buyerid;
          self.buyername = buyername;
          purchaseid += 1;
      }
      
      static func getInstance(_ productid:Int, _ productname:String,_ units:Int,_ buyerid:Int,_ buyername: String) -> Purchase {
          return Purchase(productid, productname, units, buyerid, buyername);
      }
      
      static var coca = Purchase(0, "Coca", 200, 2, "Rogelio");
      static var pepsi = Purchase(1, "Pepsi", 100, 2, "Rogelio");
      static var maruchan = Purchase(2, "Maruchan", 25, 2, "Rogelio");
      static var zucaritas = Purchase(2, "Zucaritas", 50, 4, "Rogelio");
      static var carlos = Purchase(2, "Carlos V", 125, 8, "Rogelio");
}
