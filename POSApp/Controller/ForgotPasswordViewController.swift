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
    

    @IBAction func actionButtonSubmit(_ sender: Any) {
        let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        print("value is \(fetchedUser)")
        
        if(textFieldEmail.text == ""){
            showDefaultAlertViewWith(alertTitle: "Empty Email", alertMessage: "please Enter Email Address", okTitle: "ok", currentViewController: self)
        }
   
        else{
            password = fetchedUser[0].password
            showDefaultAlertViewWith(alertTitle: "Your Password is", alertMessage: password, okTitle: "ok", currentViewController: self)
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
