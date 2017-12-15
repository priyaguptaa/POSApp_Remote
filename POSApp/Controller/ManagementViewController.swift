//
//  ManagementViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionButtonShift(_ sender: Any) {
    }
    @IBAction func actionButtonTimeStamp(_ sender: Any) {
    }
    
    @IBAction func buttonActionEmployee(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let employeeVC = storyBord.instantiateViewController(withIdentifier: "EmployeeViewController") as! EmployeeViewController
        self.navigationController?.pushViewController(employeeVC, animated: true)
        
    }
    
    @IBAction func actionButonCashInOut(_ sender: Any) {
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
