import Cocoa;
class vcPopUpModal: NSViewController {
    @objc dynamic var users: [User] = [User.admin];
    var flagAdmin: Bool = false;
    var flagModify: Bool = false;
    var userid:Int = 0;
    
    var receivedString1:String?
    var receivedString2:String?
    @IBOutlet weak var lblUsername: NSTextField!
    @IBOutlet weak var lblAction: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUsername.stringValue = receivedString1!;
        lblAction.stringValue = receivedString2!
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goRegisterFromPopUp") {
            let destinationVC = segue.destinationController as! vcRegisterForm;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.flagAdmin = flagAdmin;
            destinationVC.flagModify = flagModify;
        }
        if (segue.identifier == "goQueryFromPopUp") {
            let destinationVC = segue.destinationController as! Vcquery;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
    }
    
    @IBAction func close(_ sender: NSButton) {
        if (receivedString2 == "Eliminado") {
            performSegue(withIdentifier: "goQueryFromPopUp", sender: self)
        } else {
            performSegue(withIdentifier: "goRegisterFromPopUp", sender: self)
        }
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
