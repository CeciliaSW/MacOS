import Foundation;
var userID = 0;

class User: NSObject {
    @objc dynamic var id:Int;
    @objc dynamic var name:String;
    @objc dynamic var lastnamepaternal:String;
    @objc dynamic var lastnamematernal:String;
    @objc dynamic var email:String;
    @objc dynamic var password:String;
    @objc dynamic var dateofbirth:String;
    @objc dynamic var age:Int;
    @objc dynamic var role:String;
    @objc dynamic var color:[Double];
    @objc dynamic var image:String;
    
    private init(_ name: String,_ lastnamepaternal: String,_ lastnamematernal: String,_ email: String,_ password: String,_ dateofbirth: String,_ age: Int,_ role: String,_ color: [Double],_ image: String) {
        self.id = userID
        self.name = name
        self.lastnamepaternal = lastnamepaternal
        self.lastnamematernal = lastnamematernal
        self.email = email
        self.password = password
        self.dateofbirth = dateofbirth
        self.age = age
        self.role = role
        self.color = color;
        self.image = image;
        userID += 1
    }
    
    static func getInstance(_ name: String,_ lastnamepaternal: String,_ lastnamematernal: String,_ email: String,_ password: String,_ dateofbirth: String,_ age: Int,_ role: String,_ color: [Double],_ image: String) -> User {
        return User(name, lastnamepaternal, lastnamematernal, email, password, dateofbirth, age, role, color, image);
    }
    
    static var admin = User("Arnulfo", "Gaytán", "Álvarez", "admin@gmail.com", "Code871!", "05/07/2003", 19, "admin", [0.85, 0.76, 0.86, 1.0], "Purple Blueberry");
    static var seller = User("Cecilia", "Pena", "Bravo", "seller@gmail.com", "Code871!", "05/07/2003", 19, "seller", [0.89, 0.84, 0.75, 1.0], "Brown Chocolate");
    static var buyer = User("Rogelio", "Ceballos", "Castillo", "buyer@gmail.com", "Code871!", "05/07/2003", 19, "buyer", [0.78, 0.90, 0.69, 1.0], "Green Mint");
    static var client = User("Gerardo", "Yael", "Olvera", "client@gmail.com", "Code871!", "05/07/2003", 19, "client", [0.73, 0.82, 0.93, 1.0], "Blue Fish");
    static var miguel = User("Miguel", "Gómez", "Díaz", "miguel@gmail.com", "Code871!", "05/07/2003", 25, "client",[1.0, 0.73, 0.42, 1.0], "Orange");
}
