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
    let reachability = Reachability()!
    var activeField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCustomColor()
        setTextFieldDelegate()
        textFieldPlaceHolder()
      //  checkingNetworkReachability()
        
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
        
        var info = notification.userInfo!
        let kbSize: CGSize = ((info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size)
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
    }
    func keyboardWillHide(notification:NSNotification){
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func checkingNetworkReachability(){
        
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }
        catch{
            print("could not start notifire")
        }
    }
    
    func internetChanged(note: Notification){
        let reachability = note.object as! Reachability
        if reachability.connection != .none{
            if reachability.connection == .wifi{
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
            }
            else{
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                }
            }
        }
        else{
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        }
    }
    @IBAction func signInAction(_ sender: Any) {
     
        // fetching data base values and checking validation
        let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("Data is = \(fetchedUser)")
        
       
        
        if fetchedUser.count  > 0 {
            
            let dataDictionary : [String:String] = ["userEmail" : fetchedUser[0].email, "firstName" : fetchedUser[0].firstName, "lastName" : fetchedUser[0].lastName]
            UserDefaults.standard.set(dataDictionary, forKey: "dataDictionary")
            let result = UserDefaults.standard.value(forKey: "dataDictionary")
            print("printed results user defaults\(result!)")
            if (self.textFieldEmail.text == fetchedUser[0].email) && (self.textFieldPassword.text == fetchedUser[0].password) {
                let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                self.appDelegate.window?.rootViewController = navVC
            }
        }
        
        else if(self.textFieldEmail.text == "") && (self.textFieldPassword.text == "") {
        showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "Please Enter Email and Password", okTitle: "ok", currentViewController: self)
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

