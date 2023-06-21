//
//  vcCustomer.swift
//  TableView_2P_MacOS412
//
//  Created by MacOS on 22/05/23.
//

import Cocoa

class vcCustomer: NSViewController {
    @objc dynamic var clients: [User] = [];
   
    var clientid:Int = 0;
    
    var deletedClient: String = "";
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var tableView: NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goAdminMenuFromClients") {
            let destinationVC = segue.destinationController as! vcAdmin;
            destinationVC.users = LoginController.shared.users;
            destinationVC.userid = clientid;
        }
        
        if (segue.identifier == "goModifyFromClients") {
            let destinationVC = segue.destinationController as! vcRegisterForm;
            destinationVC.flagAdmin = true;
            destinationVC.flagModify = true;
            destinationVC.userid = txtID.integerValue;
            destinationVC.users = LoginController.shared.users;
        }
        
        if (segue.identifier == "goPopUpFromClients") {
            let destinationVC = segue.destinationController as! vcPopUpModal
            destinationVC.users = LoginController.shared.users;
            destinationVC.userid = clientid;
            destinationVC.receivedString1 = deletedClient;
            destinationVC.receivedString2 = "Eliminado";
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        performSegue(withIdentifier: "goAdminMenuFromclients", sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }

    @IBAction func btnDelete(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
                if (checkForID()) {
                    if (checkForExistingClient()) {
                        if (LoginController.shared.clients[txtID.integerValue].role != "admin") {
                            deletedClient = LoginController.shared.clients[txtID.integerValue].name;
                            LoginController.shared.deleteUser(txtID.integerValue);
                            print("Client deleted successfully");
                            performSegue(withIdentifier: "goPopUpFromClients", sender: self);
                            self.view.window?.windowController?.close();
                            dismiss(self);
                        }
                    } else {
                        print("ID textfield must be filled to delete  client.");
                    }
                }
            } else {
                print("This user is not a client.")
            }
        } else {
            print("This ID is not valid. ID must be a number.");
        }
    }
    
    @IBAction func btnModify(_ sender: NSButton) {
        if(!containsNonNumericCharacters(txtID)){
            if (isUserAClient()){
                if (checkForID()) {
                    if (checkForExistingClient()) {
                        performSegue(withIdentifier: "goModifyFromClients", sender: self);
                        self.view.window?.windowController?.close();
                        dismiss(self);
                    }
                } else {
                    print("ID textfield must be filled to modify a client.");
                }
            } else {
                print("This user is not a client.")
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
    
    func isUserAClient() -> Bool {
        if (LoginController.shared.users[txtID.integerValue].role != "client") {
            return false;
        }
        
        return true;
    }
    
    func checkForID() -> Bool {
        if (txtID.stringValue == "") {
            return false
        } else {
            return true
        }
    }
    
    func checkForExistingClient() -> Bool {
        for user in LoginController.shared.clients{
            if (user.id == txtID.integerValue) {
                print(user.id);
                return true;
            }
        }
        print("Client with this ID does not exist.");
        return false;
    }}
