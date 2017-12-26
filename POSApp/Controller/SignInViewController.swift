//
//  ViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class SignInViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
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
        facebookLoad()
        setLocalization()
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
    func setLocalization(){
        
        self.buttonSignIn.setTitle(Localizator.instance.localize(string: "key_signIn"), for: .normal)
        self.buttonForgotPassword.setTitle(Localizator.instance.localize(string: "key_forgotPassword"), for: .normal)
        
    }
    
    // set custom color
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        buttonSignIn.backgroundColor = UIColor.customRed
        
    }
    
    // set textField place holder
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: Localizator.instance.localize(string: "key_email"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: Localizator.instance.localize(string: "key_password"))
        
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
    
    func facebookLoad() {
        let loginButton = FBSDKLoginButton.init()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        let newFrame = CGPoint(x: 700, y:400)
        loginButton.center = newFrame
        loginButton.delegate = self
        view.addSubview(loginButton)
        //
        //       // Mark :- custom
        //    let myLoginButton = UIButton(type: .custom)
        //        myLoginButton.backgroundColor = UIColor.blue
        //        myLoginButton.frame = CGRect(x: 100, y: 100, width: 180, height: 80)
        //        myLoginButton.center = view.center
        //        myLoginButton.setTitle("Facebook Login ", for: .normal)
        //
        //        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        //
        //       //  Add the button to the view
        //        view.addSubview(myLoginButton)
    }
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (loginResult) in
            
            
            let responseResult = loginResult as! NSDictionary
            let strEmail: String = (responseResult.object(forKey: "email") as? String)!;
            let strFirstName: String = (responseResult.object(forKey: "first_name") as? String)!//            switch loginResult {
            //            case .failed(let error):
            //                print(error)
            //            case .cancelled:
            //                print("User cancelled login.")
            //            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
            //                print("Logged in!")
            //            }
        }
        
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
extension SignInViewController:FBSDKLoginButtonDelegate
{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,email, picture.type(large)"]).start { (connection, result, error) -> Void in
            
            if let responseResult = result as? NSDictionary {
                
                if let strEmail = responseResult.object(forKey: "email") as? String {
                    let strFirstName = responseResult.object(forKey: "first_name") as! String
                    let strLastName = responseResult.object(forKey: "last_name") as! String
                    print(strEmail)
                    
                    print(strFirstName)
                    if responseResult.count  > 0 {
                        
                        let dataDictionary:[String:String] = ["userEmail":strEmail,"firstName":strFirstName,"lastName":strLastName]
                        UserDefaults.standard.set(dataDictionary, forKey: "dataDictionary")
                        let result = UserDefaults.standard.value(forKey: "dataDictionary")
                        print(result!)
                        
                        let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                        let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                        self.appDelegate.window?.rootViewController = navVC
                        
                    }
                    
                }
                
            }
            else{
                showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "Please enter email address", okTitle: "ok", currentViewController: self)
            }
            
        }
        
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
