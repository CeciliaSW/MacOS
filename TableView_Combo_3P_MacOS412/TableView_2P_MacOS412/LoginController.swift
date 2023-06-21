import Foundation

class LoginController{
    static var shared = LoginController();
    
    @objc dynamic var users: [User] = [User.admin, User.seller, User.buyer, User.client, User.miguel];
    
    func login(_ email:String,_ password:String) -> (Bool, Int) {
        for user in 0...users.count-1{
            if (users[user].email == email && users[user].password == password) {
                return (true, users[user].id);
            }
        }
        
        return (false, 0);
    }
    
    func addUser(_ user:User) {
        print("User added successfully.");
        users.append(user);
    }
    
    func modifyUser(_ id: Int,_ user:User) {
        print("User modified succesfully.");
        users[id].name = user.name;
        users[id].lastnamepaternal = user.lastnamepaternal;
        users[id].lastnamematernal = user.lastnamematernal;
        users[id].email = user.email;
        users[id].password = user.password;
        users[id].dateofbirth = user.dateofbirth;
        users[id].age = user.age;
        users[id].role = user.role
        users[id].color = user.color;
        users[id].image = user.image;
    }
    
    func deleteUser(_ id:Int) {
        print("User deleted succesfully.");
        users.remove(at: id);
    }
}
