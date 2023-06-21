import Cocoa;
class vcWelcome: NSViewController {
    @objc dynamic var users: [User] = [];
    var userid:Int = 0;
    
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageCell!

    @IBOutlet weak var lblUser: NSTextField!
    @IBOutlet weak var lblRole: NSTextField!
    @IBOutlet weak var addBtn: NSButton!
    @IBOutlet weak var queryBtn: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblUser.stringValue = users[userid].name;
        lblRole.stringValue = users[userid].role;
        
        color = users[userid].color;
        image = users[userid].image;
        
        if(users[userid].color != [0.0]){
            view.wantsLayer = true;
            view.layer?.backgroundColor = CGColor(red: color[0], green: color[1], blue: color[2], alpha: color[3]);
        }
        if (users[userid].image != "None"){
            bgImage.image = NSImage(named: image);
        }
  
        if (users[userid].role != "admin") {
            addBtn.isEnabled = false;
            queryBtn.isEnabled = false;
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goQueryFromWelcome") {
            let destinationVC = segue.destinationController as! Vcquery;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
        
        if (segue.identifier == "goRegisterFromWelcome") {
            let destinationVC = segue.destinationController as! vcRegisterForm;
            destinationVC.flagAdmin = true;
            destinationVC.users = users;
        }
        
        if (segue.identifier == "goLoginFromWelcome") {
            let destinationVC = segue.destinationController as! vcLogin;
            destinationVC.users = users;
            destinationVC.sales = SaleController.shared.sales;
            destinationVC.products = ProductController.shared.products;
            destinationVC.purchases = PurchaseController.shared.purchases;
        }
        
        if (segue.identifier == "goAdminMenu") {
            let destinationVC = segue.destinationController as! vcAdmin;
            destinationVC.users = users;
            destinationVC.userid = userid;
        }
    }
    
    @IBAction func goMenu(_sender: NSButton){
        performSegue(withIdentifier: "goAdminMenu", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func closeAdd(_sender: NSButton){
        performSegue(withIdentifier: "goRegisterFromWelcome", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    @IBAction func closeQuery(_ sender: NSButton) {
        performSegue(withIdentifier: "goQueryFromWelcome", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);

    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goLoginFromWelcome", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}



