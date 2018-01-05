//
//  EndOfDayViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class EndOfDayViewController: UIViewController {
    
    // MARK:- Variable declaration
    
    @IBOutlet weak var buttonReserveEod: DesignButton!
    @IBOutlet weak var buttonEodReport: DesignButton!
    @IBOutlet weak var buttonEod: DesignButton!
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomLanguageValue()
        setCustomColor()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper function
    
    func setCustomColor(){
    
    buttonEod.backgroundColor = UIColor.customLightBlue
    buttonReserveEod.backgroundColor = UIColor.customLightBlue
    buttonEodReport.backgroundColor = UIColor.customLightBlue
        
    }
    
    func setCustomLanguageValue(){
        
        buttonEod.setTitle(Localizator.instance.localize(string: "key_buttonEod"), for: .normal)
        buttonEodReport.setTitle(Localizator.instance.localize(string: "key_buttonEodReport"), for: .normal)
         buttonReserveEod.setTitle(Localizator.instance.localize(string: "key_buttonReserveEod"), for: .normal)
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
