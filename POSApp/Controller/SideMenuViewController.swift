//
//  SideMenuViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableViewSideMenu: UITableView!
    var menuDictArray : [[String : String]] = [[:]]
   
//    var menuArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationController?.navigationBar.barTintColor = UIColor(red:(31/255.0), green:(31/255.0), blue:(31/255.0), alpha:1.0)
        setupView()
        loadData()
        // Do any additional setup after loading the view.
    }
    func setupView() {
        
        self.tableViewSideMenu.delegate = self
        self.tableViewSideMenu.dataSource = self
        self.tableViewSideMenu.register(UINib(nibName:"SideMenuTableViewCell", bundle:nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        self.tableViewSideMenu.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "UserProfileTableViewCell")

    }
    
    func loadData(){
        
           menuDictArray = [["name" : "","imageName" : "", "category" : "-1"], ["name" : "Home", "imageName" : "homeImage","category" : "-1"], ["name" : "Orders", "imageName" : "order1Image", "category" : "1"], ["name" : "End Of Day", "imageName" : "eod1", "category" : "3"],["name" : "Management", "imageName" : "managementImage", "category" : "2"], ["name" : "Configuration", "imageName" : "configuration", "category" : "-1"], ["name" : "Customer", "imageName" : "customerImg1", "category" : "-1"], ["name" : "Logout", "imageName" : "logoutImage", "category" : "-1"]]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDictArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            
            let userProfileCell = self.tableViewSideMenu.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell", for: indexPath) as! UserProfileTableViewCell
            userProfileCell.labelFirstName.text = "priya"
            userProfileCell.labelLastName.text = "Gupta"
            userProfileCell.labelEmailAddress.text = "priya.gupta@gmail.com"
            return userProfileCell
            
        }
            
        else {
            
         let userCell = self.tableViewSideMenu.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath)as! SideMenuTableViewCell
        userCell.labelMenuName.text = menuDictArray[indexPath.row]["name"]
         userCell.imageViewMenuItem.image = UIImage(named: menuDictArray[indexPath.row]["imageName"]!)
        return userCell
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let nameFetch = menuDictArray[indexPath.row]["name"]
        if(nameFetch == "Orders"){
            let OrderVC = storyBord.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                        self.navigationController?.pushViewController(OrderVC, animated: true)
                        OrderVC.title = "order"
        }
        else if(nameFetch == "Home"){
            let homeVC = storyBord.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
           
        }
        else if(nameFetch == "End Of Day"){
            let eodVC = storyBord.instantiateViewController(withIdentifier: "EndOfDayViewController") as! EndOfDayViewController
            self.navigationController?.pushViewController(eodVC, animated: true)
            eodVC.title = "End Of Day"
            
        }
        else if(nameFetch == "Management"){
            
            let mgntVC = storyBord.instantiateViewController(withIdentifier: "ManagementViewController") as! ManagementViewController
            self.navigationController?.pushViewController(mgntVC, animated: true)
            mgntVC.title = "Management"
        }
        else if(nameFetch == "Configuration"){
            
            let configVC = storyBord.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
            self.navigationController?.pushViewController(configVC, animated: true)
            configVC.title = "Configuration"
        }
        else if(nameFetch == "Customer"){
            
            let customerVC = storyBord.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            self.navigationController?.pushViewController(customerVC, animated: true)
            customerVC.title = "Customer"
        }
        else if(nameFetch == "Logout"){
//            let alertController = UIAlertController(title: "Are You Sure You Want to logOut", message: "press ok or cancel!", preferredStyle: .alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
//                alert -> Void in
//                
//                let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
//                self.navigationController?.present(signInVC!, animated: true, completion: nil)
//                
//            })
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: {
//                alert -> Void in
//                print("cancel")
//                
//            })
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//     }
            let refreshAlert = UIAlertController(title: "LogOut", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
                let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
            //    self.navigationController?.pushViewController(signInVC!, animated: true)
                self.navigationController?.present(signInVC!, animated: true, completion: nil)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Nevermind", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            
            return 320
            
        }
        else
        {
          return 100
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
