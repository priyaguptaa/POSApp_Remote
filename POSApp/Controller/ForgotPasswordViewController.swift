//
//  ForgotPasswordViewController.swift
//  POSApp
//
//  Created by PriyaMac on 13/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    //MARK:- Variable delaration
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonSubmit: DesignButton!
    @IBOutlet weak var viewEmail: DesignableView!
    var password = ""
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNavigation()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Helper function
    
    func designNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.customLightBlue
        self.navigationController?.view.tintColor = UIColor.white
    }
  
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
    //MARK:- Button action
    
    @IBAction func actionButtonSubmit(_ sender: Any) {
        let emailResult = isValidEmail(testStr: textFieldEmail.text!)
        let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("value is \(fetchedUser)")
        
        if (fetchedUser.count>0) {
            
            if(self.textFieldEmail.text == fetchedUser[0].email){
                
                password = fetchedUser[0].password
                showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_yourPassword"), alertMessage: password, okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
                
            }
        }
            
        else if(textFieldEmail.text == ""){
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_emptyText"), alertMessage: Localizator.instance.localize(string: "key_email"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
        }
            
        else if(emailResult == false){
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_wrongEmail"), alertMessage: Localizator.instance.localize(string: "key_correctEmail"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
            
        }
        else{
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_wrongEmail"), alertMessage: Localizator.instance.localize(string: "key_correctEmail"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
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
