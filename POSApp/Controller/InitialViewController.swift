//
//  InitialViewController.swift
//  POSApp
//
//  Created by priya gupta on 06/12/17.
//  Copyright © 2017 priya gupta. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    let reachability = Reachability()!

    @IBOutlet weak var buttonAlreadyMember: DesignButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.buttonAlreadyMember.setTitle(Localizator.instance.localize(string: "key_buttonAlreadyMember"), for: .normal)
   self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    func checkingNetworkReachability() -> Bool{
        
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }
        catch{
            print("could not start notifire")
        }
        return true
    }
    
    func internetChanged(note: Notification){
        let reachability = note.object as! Reachability
        if reachability.connection != .none{
            if reachability.connection == .wifi{
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
            }
            else{
                DispatchQueue.main.async {
                    self.view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                }
            }
        }
        else{
            DispatchQueue.main.async {
                self.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        }
    }
    @IBAction func actionButtonSignInSignUp(_ sender: Any) {
        
        if(checkingNetworkReachability() == true){
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let baseVC = storyBord.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(baseVC, animated: true)
        }
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
