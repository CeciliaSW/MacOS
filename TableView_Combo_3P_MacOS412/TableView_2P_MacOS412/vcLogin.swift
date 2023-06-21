import Cocoa;

class vcLogin: NSViewController {
    @objc dynamic var users: [User] = [];
    @objc dynamic var sales: [Sale] = [];
    @objc dynamic var purchases: [Purchase] = [];
    @objc dynamic var products: [Product] = [];
    @objc dynamic var orders: [Sale] = [];
    
    var id:Int = 0;
    
    @IBOutlet weak var lblEmail: NSTextField!
    @IBOutlet weak var lblPassword: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = LoginController.shared.users;
        products = ProductController.shared.products;
        purchases = PurchaseController.shared.purchases;
        sales = SaleController.shared.sales;
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goRegisterFromLogin") {
            (segue.destinationController as! vcRegisterForm).users = users;
        }
        if (segue.identifier == "goWelcomeFromLogin") {
            let destinationVC = segue.destinationController as! vcWelcome;
            destinationVC.users = users;
            destinationVC.userid = id;
        }
        if (segue.identifier == "goWelcomeSellerFromLogin") {
            let destinationVC = segue.destinationController as! vcWelcomeSeller;
            destinationVC.users = users;
            destinationVC.userid = id;
            destinationVC.sales = sales;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goWelcomeBuyerFromLogin") {
            let destinationVC = segue.destinationController as! vcWelcomeBuyer;
            destinationVC.users = users;
            destinationVC.userid = id;
            destinationVC.products = products;
            destinationVC.purchases = purchases;
        }
        if (segue.identifier == "goWelcomeClientFromLogin") {
            let destinationVC = segue.destinationController as! vcWelcomeClient;
            destinationVC.userid = id;
            destinationVC.users = users;
            destinationVC.orders = orders;
        }
    }
        
    @IBAction func login(_ sender: NSButton) {
        let loginResult = LoginController.shared.login(lblEmail.stringValue, lblPassword.stringValue);
        if (loginResult.0) {
            id = loginResult.1;
            print("Login successful.");
            switch (users[id].role) {
            case "admin":
                redirectToIdentifier("goWelcomeFromLogin");
            case "seller":
                redirectToIdentifier("goWelcomeSellerFromLogin");
            case "buyer":
                redirectToIdentifier("goWelcomeBuyerFromLogin");
            case "client":
                getOrdersForClient();
                redirectToIdentifier("goWelcomeClientFromLogin");
            default:
                print("some weird shit happened");
            }
        } else {
            print("Email or password is incorrect.");
        }
    }
    
    @IBAction func register(_ sender: NSButton) {
        redirectToIdentifier("goRegisterFromLogin")
    }
    
    func getOrdersForClient(){
        for sale in sales {
            if sale.clientid == id {
                orders.append(sale)
            }
        }
    }
    
    func redirectToIdentifier(_ identifier:String) {
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
