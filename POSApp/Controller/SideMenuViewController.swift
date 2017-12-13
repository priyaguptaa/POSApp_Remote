//
//  SideMenuViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableViewSideMenu: UITableView!
    var menuDictArray : [[String : String]] = [[:]]
    var userDefaultsDictionary  : [String:String] = [:]
    var appDelegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationController?.navigationBar.barTintColor = UIColor(red:(31/255.0), green:(31/255.0), blue:(31/255.0), alpha:1.0)
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        setupView()
        loadData()
        let userDefaults = UserDefaults.standard
        self.userDefaultsDictionary = userDefaults.value(forKey: "dataDictionary") as! [String:String]
        // Do any additional setup after loading the view.
    }
    func setupView() {
        
        self.tableViewSideMenu.delegate = self
        self.tableViewSideMenu.dataSource = self
        self.tableViewSideMenu.register(UINib(nibName:"SideMenuTableViewCell", bundle:nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        self.tableViewSideMenu.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "UserProfileTableViewCell")

    }
    
    func loadData(){
        
           menuDictArray = [["name" : "","imageName" : "", "category" : "-1"], ["name" : "Home", "imageName" : "homeBlack_icon","category" : "-1"], ["name" : "Orders", "imageName" : "orderBlack_icon", "category" : "1"], ["name" : "End Of Day", "imageName" : "eodBlack_icon", "category" : "3"],["name" : "Management", "imageName" : "managementBlack_icon", "category" : "2"], ["name" : "Configuration", "imageName" : "configurationBlack_icon", "category" : "-1"], ["name" : "Customer", "imageName" : "customerImg1", "category" : "-1"], ["name" : "Logout", "imageName" : "logoutBlack_icon", "category" : "-1"]]
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
//            userProfileCell.labelFirstName.text = "priya"
//            userProfileCell.labelLastName.text = "Gupta"
//            userProfileCell.labelEmailAddress.text = "priya.gupta@gmail.com"
            userProfileCell.labelFirstName.text = self.userDefaultsDictionary["firstName"]!
            userProfileCell.labelLastName.text = self.userDefaultsDictionary["lastName"]!
            userProfileCell.labelEmailAddress.text = self.userDefaultsDictionary["userEmail"]!
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

            let refreshAlert = UIAlertController(title: "LogOut", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertControllerStyle.alert)
             refreshAlert.view.tintColor = UIColor.red
      
            refreshAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: {
              
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseViewController")
                    let  navVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialNavVC") as! UINavigationController
                    navVC.setViewControllers([viewController], animated: false)
                    self.appDelegate.window?.rootViewController = navVC
                    self.dismissModalStack()
                })
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Nevermind", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        else if(indexPath.row == 0){
            
            let signUpVC = storyBord.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(signUpVC, animated: true)
            let scene = SceneType.SideMenuScene
            signUpVC.sceneType = scene
        }
    }
    func dismissModalStack() {
        
        var vc: UIViewController? = self.presentedViewController
        while ((vc?.presentedViewController) != nil) {
            vc = vc?.presentingViewController
        }
        vc?.dismiss(animated: true, completion: { _ in })
        
        var svc: UIViewController? = SideMenuManager.menuLeftNavigationController?.presentingViewController

        while ((svc?.presentedViewController) != nil) {
            svc = svc?.presentingViewController
        }
        svc?.dismiss(animated: true, completion: { _ in })
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0) {
            
            return 300
            
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
}
