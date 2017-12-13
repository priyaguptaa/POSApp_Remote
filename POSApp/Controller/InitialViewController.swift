//
//  InitialViewController.swift
//  POSApp
//
//  Created by priya gupta on 06/12/17.
//  Copyright © 2017 priya gupta. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var buttonSignInSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionButtonSignInSignUp(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let baseVC = storyBord.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        navigationController?.pushViewController(baseVC, animated: true)
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
