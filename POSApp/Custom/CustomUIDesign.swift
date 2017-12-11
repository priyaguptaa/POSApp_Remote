//
//  CustomUIDesign.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class DesignButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable var cornerBorder: CGFloat = 0.0 {
        didSet{
           self.layer.cornerRadius = cornerBorder
            self.layer.masksToBounds = cornerBorder<0
        }
    }
}
@IBDesignable
class DesignableView: UIView {
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
            
        }
    }
    
}
@IBDesignable
class DesignableTextField: UITextField {
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
}

@IBDesignable
class DesignableLabel: UILabel {
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
}
 
