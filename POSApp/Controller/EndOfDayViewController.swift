//
//  EndOfDayViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class EndOfDayViewController: UIViewController {

    @IBOutlet weak var buttonReserveEod: DesignButton!
    @IBOutlet weak var buttonEodReport: DesignButton!
    @IBOutlet weak var buttonEod: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomColor()
        // Do any additional setup after loading the view.
        
    }
    
    func setCustomColor(){
    
    buttonEod.backgroundColor = UIColor.customLightBlue
    buttonReserveEod.backgroundColor = UIColor.customLightBlue
    buttonEodReport.backgroundColor = UIColor.customLightBlue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
