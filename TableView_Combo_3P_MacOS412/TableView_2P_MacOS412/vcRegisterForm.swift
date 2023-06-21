import Cocoa;
class vcRegisterForm: NSViewController, NSComboBoxDelegate, NSComboBoxDataSource  {
    @objc dynamic var users: [User] = [User.admin];
    let colors = ["None", "Light Blue","Light Purple","Light Orange","Light Green", "Light Brown"];
    let cgcolors = [[0.0],[0.73, 0.82, 0.93, 1.0], [0.85, 0.76, 0.86, 1.0], [1.0, 0.73, 0.42, 1.0], [0.78, 0.9, 0.69, 1.0], [0.89, 0.84, 0.75, 1.0]];
    let images = ["None", "Blue Fish","Purple Blueberry","Orange","Green Mint", "Brown Chocolate"];
    var selectedValueColor: String = "";
    var selectedValueCGColor: [Double] = [];
    var selectedValueImg: String = "";
    
    var flagAdmin: Bool = false;
    var flagModify: Bool = false;
    var userid:Int = 0;
    
    let calendar = Calendar.current

    var referenceDate: Date? {
        let dateComponents = DateComponents(year: 2005, month: 1, day: 1)
        return calendar.date(from: dateComponents)
    }

    @IBOutlet weak var txtAction: NSTextField!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var txtRole: NSTextField!
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtLastNamePaternal: NSTextField!
    @IBOutlet weak var txtLastNameMaternal: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtConfirmPassword: NSTextField!
    @IBOutlet weak var btnAction: NSButton!
    @IBOutlet weak var cmbColor: NSComboBox!
    @IBOutlet weak var cmbImage: NSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtID.integerValue = users.count
        txtID.isEnabled = false
        txtRole.stringValue = "client"
        txtRole.isEnabled = false
    
        manipulateCombo(cmbColor, items: colors)
        manipulateCombo(cmbImage, items: images)
        
        cmbColor.selectItem(at: 0)
        cmbImage.selectItem(at: 0)
        
        if (flagAdmin) {
            txtRole.isEnabled = true
        }
        if (flagModify) {
            if users[userid].role == "admin" {
                txtRole.isEnabled = false
            } else {
                txtRole.isEnabled = true
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d/M/yyyy"
            
            txtAction.stringValue = "Modificación"
            txtID.integerValue = users[userid].id;
            txtRole.stringValue = users[userid].role;
            txtName.stringValue = users[userid].name;
            txtLastNamePaternal.stringValue = users[userid].lastnamepaternal;
            txtLastNameMaternal.stringValue = users[userid].lastnamematernal;
            txtEmail.stringValue = users[userid].email;
            datePicker.dateValue = dateFormatter.date(from: users[userid].dateofbirth)!
            
            txtPassword.stringValue = users[userid].password;
            txtConfirmPassword.stringValue = users[userid].password;
            btnAction.title = "Modificar"
            
            selectedValueCGColor = users[userid].color;
            selectedValueImg = users[userid].image;
            
            for color in 0...colors.count-1 {
                if (selectedValueCGColor == cgcolors[color]) {
                    cmbColor.selectItem(at: color)
                }
            }
            for image in 0...images.count-1 {
                if (selectedValueImg == images[image]) {
                    cmbImage.selectItem(at: image)
                }
            }
        }
        
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goWelcomeFromRegister") {
            let destinationVC = segue.destinationController as! vcWelcome;
            destinationVC.userid = userid;
            destinationVC.users = LoginController.shared.users;
        }
        
        if (segue.identifier == "goLoginFromRegister"){
            let destinationVC = segue.destinationController as! vcLogin;
            destinationVC.id = userid;
            destinationVC.users = LoginController.shared.users;
        }
        
        if (segue.identifier == "goQueryFromRegister"){
            let destinationVC = segue.destinationController as! Vcquery;
            destinationVC.users = LoginController.shared.users;
        }
        
        if (segue.identifier == "goPopUpFromRegister") {
            let destinationVC = segue.destinationController as! vcPopUpModal;
            destinationVC.users = LoginController.shared.users;
            destinationVC.userid = userid;
            destinationVC.flagAdmin = flagAdmin;
            destinationVC.flagModify = flagModify;
            destinationVC.receivedString1 = LoginController.shared.users[txtID.integerValue].name;
            if (flagModify) {
                destinationVC.receivedString2 = "Actualizado";
            } else {
                destinationVC.receivedString2 = "Agregado";
            }
        }
    }
    
    @IBAction func register(_ sender: NSButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        let selectedDate = datePicker.dateValue
        let dateString = dateFormatter.string(from: selectedDate)
        
        if (areFieldsCompleted() && isFormatCorrect() && isAgeValid()){
            if (!checkForExistingUser() || flagModify) {
                if (verifyPassword()) {
                    if (checkValidRole()) {
                        let user = User.getInstance(txtName.stringValue, txtLastNamePaternal.stringValue, txtLastNameMaternal.stringValue, txtEmail.stringValue, txtPassword.stringValue, dateString, calculateAge(from: selectedDate), txtRole.stringValue, selectedValueCGColor, selectedValueImg);
                        if (flagModify) {
                            LoginController.shared.modifyUser(userid, user)
                        } else {
                            LoginController.shared.addUser(user);
                        }
                        performSegue(withIdentifier: "goPopUpFromRegister", sender: self);
                        txtID.integerValue = LoginController.shared.users.count
                        self.view.window?.windowController?.close();
                        dismiss(self);
                    } else {
                        print("Role is not valid.");
                    }
                } else {
                    print("Password and Confirm Password do not match.");
                }
            } else {
                print("An account is already registered with this e-mail.");
            }
        }
    }
    
    @IBAction func btnReturn(_ sender: NSButton) {
        var identifier: String;
        if (flagModify) {
            identifier = "goQueryFromRegister"
        } else if (flagAdmin) {
            identifier = "goWelcomeFromRegister"
        } else {
            identifier = "goLoginFromRegister"
        }
        performSegue(withIdentifier: identifier, sender: self);
        self.view.window?.windowController?.close();
        dismiss(self);
    }
    
    func manipulateCombo(_ combobox: NSComboBox,items: [String]){
        combobox.delegate = self;
        combobox.dataSource = self;
        for item in items{
            combobox.addItem(withObjectValue: item);
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let comboBox = notification.object as? NSComboBox {
            let selectedIndex = comboBox.indexOfSelectedItem;
            
            if (comboBox == cmbColor) {
                selectedValueColor = colors[selectedIndex];
                selectedValueCGColor = cgcolors[selectedIndex];
            } else if (comboBox == cmbImage) {
                selectedValueImg = images[selectedIndex];
            }

            let value: [String?] = [selectedValueColor, selectedValueImg]
            print("Selection: \(value)");
        }
    }
    
    func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()

        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

        let currentDays = (currentComponents.day ?? 0) + ((currentComponents.month ?? 0) * 30) + ((currentComponents.year ?? 0) * 365)
        let pastDays = (components.day ?? 0) + ((components.month ?? 0) * 30) + ((components.year ?? 0) * 365)

        let age = Int(floor(Double((currentDays - pastDays) / 365)))

        print(age)
        return age
    }

    
    func isAgeValid()  -> Bool {
        let age = calculateAge(from: datePicker.dateValue)
        if (age < 18 || age > 100){
            print("Invalid age.");
            return false;
        }
        
        return true;
    }
    
    func areFieldsCompleted()  -> Bool{
        let fields: [(textField: NSTextField, errorMessage: String)] = [
            (txtRole, "Role is missing."),
            (txtName, "Name is missing."),
            (txtLastNamePaternal, "Last Name (Paternal) is missing."),
            (txtLastNameMaternal, "Last Name (Maternal) is missing."),
            (txtEmail, "Email is missing."),
            (txtPassword, "Password is missing."),
            (txtConfirmPassword, "Confirm Password is missing.")
        ]
        
        for field in fields {
            let textField = field.textField
            let errorMessage = field.errorMessage
            
            if textField.stringValue.isEmpty {
                print(errorMessage)
                return false;
            }
        }
        
        if datePicker.dateValue == referenceDate {
            print("Date is missing.")
            return false;
        }
        
        return true;
    }
    
    func isFormatCorrect()  -> Bool{
        let fields: [NSTextField] = [txtName, txtLastNameMaternal, txtLastNamePaternal]
        
        for field in fields {
            if textFieldHasSpecialCharactersAndNumbers(field) {
                print("No numbers or special characters are accepted on this field.")
                return false;
            }
            
            if !TextfieldHasValidName(field){
                return false;
            }
        }
        
        if(!textFieldHasValidEmailFormat(txtEmail)){
            print("E-mail does not meet the requirements.")
            return false;
        }
        
        if(!passwordHasValidFormat(txtPassword)){
            print("Password does not meet the requirements.")
            return false;
        }
        
        return true;
    }
    
    func TextfieldHasValidName(_ textUser: NSTextField) -> Bool {
        let textfield = textUser.stringValue
        
        if textfield.count < 3 {
            print("Not valid name or lastname.")
            return false
        }
        
        return true
    }
    
    func textFieldHasSpecialCharactersAndNumbers(_ textField: NSTextField) -> Bool {
        let specialCharAndNumberRegex = ".*[^A-Za-z0-9áéíóúÁÉÍÓÚ]+.*|.*\\d+.*"
        let specialCharAndNumberPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharAndNumberRegex)
        return specialCharAndNumberPredicate.evaluate(with: textField.stringValue)
    }

    func textFieldHasValidEmailFormat(_ textField: NSTextField) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: textField.stringValue)
    }

    func checkForExistingUser() -> Bool {
        for user in users {
            if (user.email == txtEmail.stringValue) {
                return true;
            }
        }
        return false;
    }

    func passwordHasValidFormat(_ passwordField: NSTextField) -> Bool {
        let password = passwordField.stringValue

        if password.count < 8 {
            print("Password must be at least eight characters long.")
            return false
        }
        
        let numberRegex = ".*[0-9]+.*"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        if !numberPredicate.evaluate(with: password) {
           
            print("Password must have at least one number.")
            return false
        }
        
        let uppercaseRegex = ".*[A-Z]+.*"
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        if !uppercasePredicate.evaluate(with: password) {
            
            print("Password must have at least one capital letter.")
            return false
        }
        
        let specialCharRegex = ".*[^A-Za-z0-9]+.*"
        let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        if !specialCharPredicate.evaluate(with: password) {
         
            print("Password must have at least one special character.")
            return false
        }
        
        print("Password meets the requirements.")
        return true
    }
    
    func verifyPassword() -> Bool {
        if (txtPassword.stringValue == txtConfirmPassword.stringValue) {
            return true;
        } else {
            return false;
        }
    }
    
    func checkValidRole() -> Bool {
        if (txtRole.stringValue == "client" || txtRole.stringValue == "buyer" || txtRole.stringValue == "seller" || txtRole.stringValue == "admin") {
            return true;
        } else {
            return false;
        }
    }
}
