import Cocoa

class vcModal: NSViewController {

    
    @IBOutlet weak var lblAction: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: NSButton) {
        self.view.window?.windowController?.close();
        dismiss(self);
    }
}
