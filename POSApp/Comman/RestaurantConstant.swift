//
//  RestaurantConstant.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import Foundation
import UIKit

func  showDefaultAlertViewWith(alertTitle:String, alertMessage:String, okTitle:String, currentViewController :UIViewController) {
    
    let alert = UIAlertController(title: alertTitle, message:alertMessage, preferredStyle:.alert)
    alert.addAction(UIAlertAction(title: okTitle, style: .default) { action in
    })
    currentViewController.present(alert, animated: true, completion: nil)
}

func createAttributedPlacedholderToTextField(currentTextField : UITextField, currentPlaceholderText : String) {
    
    currentTextField.attributedPlaceholder = NSAttributedString(string:currentPlaceholderText,attributes: [NSForegroundColorAttributeName: UIColor.white])
    
}

func applyAttributedNavigationBarTitleWith(currentTitle : String, currentNavigationController: UINavigationController) {
    
    currentNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    currentNavigationController.title = currentTitle
    
}

