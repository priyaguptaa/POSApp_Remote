//
//  ForgotPasswordViewController.swift
//  POSApp
//
//  Created by PriyaMac on 13/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonSubmit: DesignButton!
    @IBOutlet weak var viewEmail: DesignableView!
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        designNavigation()
        // Do any additional setup after loading the view.
    }

    func designNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.customLightBlue
        self.navigationController?.view.tintColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }

    @IBAction func actionButtonSubmit(_ sender: Any) {
        let emailResult = isValidEmail(testStr: textFieldEmail.text!)
        let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("value is \(fetchedUser)")
        
        if (fetchedUser.count>0) {
            
             if(self.textFieldEmail.text == fetchedUser[0].email){
                
                password = fetchedUser[0].password
                showDefaultAlertViewWith(alertTitle: "Your Password is", alertMessage: password, okTitle: "ok", currentViewController: self)
                
            }
        }
       
         else if(textFieldEmail.text == ""){
            
            showDefaultAlertViewWith(alertTitle: "Empty Text", alertMessage: "Enter Email address", okTitle: "ok", currentViewController: self)
        }
        
  else if(emailResult == false){
            showDefaultAlertViewWith(alertTitle: "Wrong Email", alertMessage: "Enter Correct Email", okTitle: "ok", currentViewController: self)
    }

//             else if(self.textFieldEmail.text == fetchedUser[0].email){
////            showDefaultAlertViewWith(alertTitle: "Empty Email", alertMessage: "please Enter Email Address", okTitle: "ok", currentViewController: self)
//
//            password = fetchedUser[0].password
//            showDefaultAlertViewWith(alertTitle: "Your Password is", alertMessage: password, okTitle: "ok", currentViewController: self)
//
//        }
        else{
                    showDefaultAlertViewWith(alertTitle: "Wrong Email", alertMessage: "please Enter Correct Email Address", okTitle: "ok", currentViewController: self)
        }
      
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
