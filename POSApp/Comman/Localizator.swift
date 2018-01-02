//
//  Localizator.swift
//  POSApp
//
//  Created by PriyaMac on 15/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
class Localizator {
    
    static let instance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        
        if let path = Bundle.main.path(forResource: "LocalizationList", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        
        guard let localizedString = (localizableDictionary.value(forKey: string) as! NSDictionary).value(forKey: "value") as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        return localizedString
    }
}
