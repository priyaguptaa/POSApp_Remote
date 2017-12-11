//
//  UIColor.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 28/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    @nonobjc static var customGreen: UIColor {
        let darkGreen = 0x5C8B9C
        return UIColor.rgb(fromHex: darkGreen)
    }
    
    class func rgb(fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @nonobjc static var customRed: UIColor {
        
        return UIColor(red: 254/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0)
    }
    
    @nonobjc static var customLightBlue: UIColor {
        
        return UIColor(red: 92/255.0, green: 139/255.0, blue: 156/255.0, alpha: 0.75)
    }
    
    @nonobjc static var customWhite: UIColor {
        
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @nonobjc static var customLightGray: UIColor {
        
        return UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 0.8)
    }
    
    @nonobjc static var customWhiteGray: UIColor {
        
        return UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
    }
    
    @nonobjc static var customblack: UIColor {
        
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    }
        
}
