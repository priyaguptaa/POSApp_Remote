//
//  ViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordAction: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var buttonSignIn: UIButton!
    var appDelegate = AppDelegate()
     var dataDictionary : [String:AnyObject] = [:]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCustomColor()
        setTextFieldDelegate()
        textFieldPlaceHolder()
        
        textFieldEmail.text = "priya.gupta@gmail.com"
        textFieldPassword.text = "priya123"
        
        // for keybord show and hide
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // set custom color
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        buttonSignIn.backgroundColor = UIColor.customRed
        
    }
    
    // set textField place holder
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: " Enter Email Address")
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: "Enter Password")
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
        
    }
    
    func setTextFieldDelegate(){
        
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
    
    @IBAction func signInAction(_ sender: Any) {
     
        // fetching data base values and checking validation
    let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("Data is = \(fetchedUser)")
        
        let dataDictionary : [String:String] = ["userEmail" : fetchedUser[0].email, "firstName" : fetchedUser[0].firstName, "lastName" : fetchedUser[0].lastName]
        UserDefaults.standard.set(dataDictionary, forKey: "dataDictionary")
        let result = UserDefaults.standard.value(forKey: "dataDictionary")
        print("printed results user defaults\(result!)")
        if fetchedUser.count  > 0 {
            if (self.textFieldEmail.text == fetchedUser[0].email) && (self.textFieldPassword.text == fetchedUser[0].password) {
                let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                self.appDelegate.window?.rootViewController = navVC
            
            }
            
        }
           
        
        else if(self.textFieldEmail.text == "") && (self.textFieldPassword.text == "") {
        showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Email and Password", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldEmail.text == "") {
            showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Email ", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldPassword.text == ""){
            showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Password ", okTitle: "ok", currentViewController: self)
        }
            
      else{
        showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "Please Enter Email and Password", okTitle: "ok", currentViewController: self)
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {

        let forgotVC  = self.storyboard?.instantiateViewController(withIdentifier:  "ForgetVC") as!   ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

