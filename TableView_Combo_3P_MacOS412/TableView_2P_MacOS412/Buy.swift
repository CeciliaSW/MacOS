import Foundation

var buyId = 0;

  class Buy: NSObject {
      @objc dynamic var id:Int;
      @objc dynamic var productId:Int;
      @objc dynamic var buyerId:Int;
      @objc dynamic var productInformation:String;
      @objc dynamic var units:Int;
    
      private init(_ productId:Int,_ buyerId:Int, _ productInformation:String,_ units:Int) {
          self.id = buyId;
          self.productId = productId;
          self.buyerId = buyerId;
          self.productInformation = productInformation;
          self.units = units;
          buyId += 1;
      }
      
      static func getInstance(_ productId:Int,_ buyerId:Int,_ productInformation:String, _ units:Int) -> Buy {
          return Buy(productId, buyerId, productInformation,units);
      }
}
