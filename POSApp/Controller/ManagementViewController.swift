//
//  ManagementViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {

    @IBOutlet weak var buttonShift: DesignButton!
    @IBOutlet weak var buttonCashInOut: DesignButton!
    @IBOutlet weak var buttonEmployee: DesignButton!
    @IBOutlet weak var buttonTimeStamp: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomLanguageValue()
        // Do any additional setup after loading the view.
    }
    func setCustomLanguageValue(){
        
        
        buttonShift.setTitle(Localizator.instance.localize(string: "key_buttonShift"), for: .normal)
        buttonTimeStamp.setTitle(Localizator.instance.localize(string: "key_buttonTimeStamp"), for: .normal)
        buttonEmployee.setTitle(Localizator.instance.localize(string: "key_buttonEmployee"), for: .normal)
        buttonCashInOut.setTitle(Localizator.instance.localize(string: "key_buttonCashInOut"), for: .normal)
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
