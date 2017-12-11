//
//  RegisterViewController.swift
//  POSApp
//
//  Created by priya gupta on 06/12/17.
//  Copyright © 2017 priya gupta. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var signUpContainerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var signInContainerView: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  set segment control font size
        let attribute = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 25.0)!, forKey: NSFontAttributeName as NSCopying)
        segmentControl.setTitleTextAttributes(attribute as [NSObject : AnyObject] , for: .normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex {
            
        case 0:
            print("Sign in segment selected")
            signUpContainerView.isHidden = true
            signInContainerView.isHidden = false
        case 1:
            print("Sign up segment selected")
            signUpContainerView.isHidden = false
            signInContainerView.isHidden = true
        default:
            break;
            
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
