//
//  SignUpViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var users: [UserInfo]!
    var dataBase : FMDatabase = FMDatabase()
    var dataArray: [AnyObject] = []
   var sceneType : SceneType? = nil
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var firstName = ""
    var lastName = ""
    var email = ""
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        setTextFieldDelegate()
        textFieldPlaceHolder()
        setCustomColor()
        
        switch sceneType {
        case .InitialScene?:
            self.buttonSignUp.titleLabel?.text = "Sign Up"
            break
        case .SideMenuScene?:
            
            self.buttonSignUp.setTitle("Update", for: .normal)
                viewPassword.isHidden = true
            
                textFieldFirstName.text = firstName
                textFieldLastName.text = lastName
                textFieldEmail.text = email
            textFieldEmail.isUserInteractionEnabled = false
            
            break
        default : break
        }
        
        let dataSharedInstance = DBManager.shared
        dataSharedInstance.fetchTextFieldValue(withFirstName: textFieldFirstName.text!, withLastName: textFieldLastName.text!, withEmail: textFieldEmail.text!, withPassword: textFieldPassword.text!)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func setCustomColor(){
        
    buttonSignUp.backgroundColor = UIColor.customRed
    viewFirstName.backgroundColor = UIColor.customLightBlue
    viewLastName.backgroundColor = UIColor.customLightBlue
    viewEmail.backgroundColor  = UIColor.customLightBlue
    viewPassword.backgroundColor = UIColor.customLightBlue
        
    }

    func textFieldPlaceHolder(){
      
        createAttributedPlacedholderToTextField(currentTextField: textFieldFirstName, currentPlaceholderText: "Enter First Name")
        createAttributedPlacedholderToTextField(currentTextField: textFieldLastName, currentPlaceholderText: "Enter Last Name")
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: "Enter Email Address")
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: "Enter Password")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldFirstName.resignFirstResponder()
        textFieldLastName.resignFirstResponder()
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
        
    }
    
    func setTextFieldDelegate(){
        
        textFieldFirstName.delegate = self
        textFieldLastName.delegate = self
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
    }

    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentInset = contentInset
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
     
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
    func isValidPincode(value: String) -> Bool {
        
        var status : Bool = true
        
        if value.count < 6 {
            
            status = false
        }
        
        return status
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        switch sceneType {
        case .InitialScene?:
            checkFieldsValidation()
            break
        case .SideMenuScene?:
           
        DBManager.shared.updateUserInfo(firstName: self.textFieldFirstName.text!, lastName: self.textFieldLastName.text!, email: self.textFieldEmail.text!)
        let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("Data is = \(fetchedUser)")
        
        let dataDictionary : [String:String] = ["userEmail" : fetchedUser[0].email, "firstName" : fetchedUser[0].firstName, "lastName" : fetchedUser[0].lastName]
        UserDefaults.standard.set(dataDictionary, forKey: "dataDictionary")
        let result = UserDefaults.standard.value(forKey: "dataDictionary")
        print("printed  update results user defaults\(result!)")
          showDefaultAlertViewWith(alertTitle: "data update", alertMessage: "data update succesfully", okTitle: "ok", currentViewController: self)
        
            
            break
        default : break
        }
    
     //   checkFieldsValidation()
        
    }
    
    func checkFieldsValidation(){
        
        let emailResult = isValidEmail(testStr: textFieldEmail.text!)
        let passwordResult = isValidPincode(value:textFieldPassword.text!)
        if ((emailResult&&passwordResult == true) && ((textFieldFirstName.text != "") && (textFieldLastName.text != ""))){
                DBManager.shared.insertIntoPosUser(fname: self.textFieldFirstName.text!, lname: self.textFieldLastName.text!, email: self.textFieldEmail.text!, pwd: self.textFieldPassword.text!)
                let alertController = UIAlertController(title: "save", message: "Data Inserted Successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                alert -> Void in
                //                let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                //                let  searchSIVC = storyB.instantiateViewController(withIdentifier: "SignInViewController") as! ViewController
                //                self.navigationController?.pushViewController(searchSIVC, animated: true)            
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if ((self.textFieldEmail.text == "") && (self.textFieldPassword.text == "") && (textFieldFirstName.text  == "") && (textFieldLastName.text == "")) {
            showDefaultAlertViewWith(alertTitle: "empty ", alertMessage: "Please enter all field", okTitle: "discard", currentViewController: self)
        }
        else if ((self.textFieldPassword.text == "") && (self.textFieldFirstName.text != "") && (self.textFieldLastName.text != "") && (self.textFieldEmail.text != "")) {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please Enter Password", okTitle: "discard", currentViewController: self)
        }
        else if (textFieldFirstName.text  == "")  {
            
            showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "please enter first name", okTitle: "ok", currentViewController: self)
        }
        else if (textFieldLastName.text  == "") {
            
            showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "please enter last name", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldEmail.text == "") {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please enter Email Address", okTitle: "dismiss", currentViewController: self)
        }
        else {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please enter correct email & password", okTitle: "discard", currentViewController: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
