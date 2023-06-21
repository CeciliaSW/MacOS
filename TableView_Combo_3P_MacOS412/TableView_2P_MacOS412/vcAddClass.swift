import Cocoa;
class vcAddClass: NSViewController {
    /*
    @objc dynamic var users: [User] = [User.admin];
    var flag: Bool = false;
    var position: Int!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var txtRole: NSTextField!
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtLastNamePaternal: NSTextField!
    @IBOutlet weak var txtLastNameMaternal: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtPhoneNumber: NSTextField!
    @IBOutlet weak var txtGender: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmPassword: NSTextField!
    @IBOutlet weak var AddBtn: NSButton!
    @IBOutlet weak var UpdateBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateBtn.isHidden = !flag;
        AddBtn.isHidden = flag;
        txtID.integerValue = users.count
        txtID.isEnabled = false
        
        if (flag){
            txtID.integerValue = users[position].id;
            txtRole.stringValue = users[position].role;
            txtName.stringValue = users[position].name;
            txtLastNamePaternal.stringValue = users[position].lastnamepaternal;
            txtLastNameMaternal.stringValue = users[position].lastnamematernal;
            txtEmail.stringValue = users[position].email;
            
            txtPassword.stringValue = users[position].password;
            txtConfirmPassword.stringValue = users[position].password;
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goPopUpFromAdd") {
            let destino = segue.destinationController as! vcPopUpModal
            destino.receivedString1 = LoginController.shared.users[txtID.integerValue].name;
            destino.receivedString2 = "Agregado";
        }
        
        if (segue.identifier == "goPopUpFromUpdate") {
            let destino = segue.destinationController as! vcPopUpModal
            destino.receivedString1 = LoginController.shared.users[position].name;
            destino.receivedString2 = "Actualizado";
        }
        
        if(segue.identifier == "goWelcomeFromAdd"){
            (segue.destinationController as! vcWelcome).users = users;
        }
        
        if(segue.identifier == "goQueryFromAdd"){
            (segue.destinationController as! Vcquery).users = users;
        }
}
    
    @IBAction func register(_ sender: NSButton) {
        if (!checkForExistingUser() || flag) {
            if (verifyPassword()) {
                let user = User.getInstance(txtName.stringValue, txtLastNamePaternal.stringValue, txtLastNameMaternal.stringValue, txtEmail.stringValue, txtPhoneNumber.stringValue, txtGender.stringValue, txtPassword.stringValue, txtRole.stringValue);
                if (flag) {
                    LoginController.shared.modifyUser(position, user)
                    performSegue(withIdentifier: "goPopUpFromUpdate", sender: self);
                } else {
                    LoginController.shared.addUser(user);
                    performSegue(withIdentifier: "goPopUpFromAdd", sender: self);
                }
                txtID.integerValue = LoginController.shared.users.count
            } else {
                print("Password and Confirm Password do not match.");
            }
        } else {
            print("An account is already registered with this e-mail.");
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        if (!flag) {
            performSegue(withIdentifier: "goWelcomeFromAdd", sender: self);
        } else {
            performSegue(withIdentifier: "goQueryFromAdd", sender: self);
        }
        dismiss(self);
    }
    
    func checkForExistingUser() -> Bool {
        for user in LoginController.shared.users {
            if (user.email == txtEmail.stringValue) {
                return true;
            }
        }
        return false;
    }
    
    func verifyPassword() -> Bool {
        if (txtPassword.stringValue == txtConfirmPassword.stringValue) {
            return true;
        } else {
            return false;
        }
    }
     */
}
