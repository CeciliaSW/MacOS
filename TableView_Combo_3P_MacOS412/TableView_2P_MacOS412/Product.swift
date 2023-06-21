import Foundation

var productid = 0;

  class Product: NSObject {
    @objc dynamic var id:Int;
    @objc dynamic var name:String;
    @objc dynamic var details:String;
    @objc dynamic var price:Double;
    @objc dynamic var cost:Double;
    @objc dynamic var category:String;
    
      private init(_ name:String, _ details:String, _ price:Double, _ cost: Double, _ category: String) {
          self.id = productid
          self.name = name;
          self.details = details;
          self.price = price;
          self.cost = cost;
          self.category = category
          productid += 1
      }
      
      static func getInstance(_ name: String,_ details: String,_ price: Double,_ cost: Double,_ category:String) -> Product {
          return Product(name, details, price, cost, category);
      }
      
      static var coca = Product("Coca", "Bebida", 15, 10, "Alimentos");
      static var pepsi = Product("Pepsi", "Bebida", 13, 9, "Alimentos");
      static var maruchan = Product("Maruchan", "Comida", 12, 8, "Alimentos");
      static var zucaritas = Product("Zucaritas", "Comida", 14, 11, "Alimentos");
      static var carlos = Product("Carlos V", "Comida", 16, 13, "Alimentos");
}
