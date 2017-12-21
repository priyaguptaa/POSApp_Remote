//
//  POSManager.swift
//  POSApp
//
//  Created by priya gupta on 06/12/17.
//  Copyright © 2017 priya gupta. All rights reserved.
//


/*
 
  Class for Functionality is to create only one instance of an object and prevents its methods from being overridden
 */

import Foundation

// MARK: - Singleton

final class POSManger{
    
    //MARK: Approch 1
//    static let shared = POSManger()
    
    //MARK: Better Approch 2
    
    // Can't init is singleton
    private init() {}
    
    // MARK: Shared Instance
    static let shared = POSManger()
    
    // MARK: Variables
 var localizeString = ""

}
