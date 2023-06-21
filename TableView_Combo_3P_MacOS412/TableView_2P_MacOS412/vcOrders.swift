import Cocoa

class vcOrders: NSViewController {

    @objc dynamic var users: [User] = [];
    @objc dynamic var orders: [Sale] = [];
    
    var userid:Int = 0;
  
    var color:[Double] = [];
    var image:String = "";
    @IBOutlet weak var bgImage: NSImageView!
    
    @IBOutlet weak var tableView: NSTableView!

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
        if (segue.identifier == "goWelcomeClientFromQueryOrders") {
            let destinationVC = segue.destinationController as! vcWelcomeClient;
            destinationVC.users = users;
            destinationVC.userid = userid;
            destinationVC.orders = orders;
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goWelcomeClientFromQueryOrders", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
