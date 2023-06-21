import Cocoa;
class Vcquery: NSViewController {
    @objc dynamic var users: [User] = [User.admin];
    var userid:Int = 0;
    
    var deletedUsername: String = "";
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        color = users[userid].color;
        image = users[userid].image;
        
        if(users[userid].color != [0.0]){
            view.wantsLayer = true;
            view.layer?.backgroundColor = CGColor(red: color[0], green: color[1], blue: color[2], alpha: color[3]);
        }
        if (users[userid].image != "None"){
            bgImage.image = NSImage(named: image);
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeFromQuery") {
            let destinationVC = segue.destinationController as! vcWelcome;
            destinationVC.users = LoginController.shared.users;
            destinationVC.userid = userid;
        }
        if (segue.identifier == "goModify") {
            let destinationVC = segue.destinationController as! vcRegisterForm;
            destinationVC.flagAdmin = true;
            destinationVC.flagModify = true;
            destinationVC.userid = txtID.integerValue;
            destinationVC.users = LoginController.shared.users;
        }
        
        if (segue.identifier == "goPopUpFromQuery") {
            let destinationVC = segue.destinationController as! vcPopUpModal
            destinationVC.users = LoginController.shared.users;
            destinationVC.userid = userid;
            destinationVC.receivedString1 = deletedUsername;
            destinationVC.receivedString2 = "Eliminado";
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goWelcomeFromQuery", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }

    @IBAction func btnDelete(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingUser()) {
                    if (LoginController.shared.users[txtID.integerValue].role != "admin") {
                        deletedUsername = LoginController.shared.users[txtID.integerValue].name;
                        LoginController.shared.deleteUser(txtID.integerValue);
                        performSegue(withIdentifier: "goPopUpFromQuery", sender: self);
                        self.view.window?.windowController?.close();
                        dismiss(self);
                    } else {
                        print("Admin users cannot be deleted.")
                    }
                }
            } else {
                print("ID textfield must be filled to delete an user.");
            }
        } else {
            print("This ID is not valid. ID must be a number.")
        }
    }
    
    @IBAction func btnModify(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (checkForID()) {
                if (checkForExistingUser()) {
                    performSegue(withIdentifier: "goModify", sender: self);
                    self.view.window?.windowController?.close();
                    dismiss(self);
                }
            } else {
                print("ID textfield must be filled to modify an user.");
            }
        }else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    func containsNonNumericCharacters(_ textField: NSTextField) -> Bool {
        let nonNumericRegex = "[^0-9]"
        let text = textField.stringValue
        
        let regex = try! NSRegularExpression(pattern: nonNumericRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }

    func checkForID() -> Bool {
        if (txtID.stringValue == "") {
            return false
        } else {
            return true
        }
    }
    
    func checkForExistingUser() -> Bool {
        for user in LoginController.shared.users {
            if (user.id == txtID.integerValue) {
                return true;
            }
        }
        print("User with this ID does not exist.");
        return false;
    }
}

