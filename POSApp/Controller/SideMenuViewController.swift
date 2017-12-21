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
    var userDefaultsDictionary  : [String:String] = [:]
    var menuDictArray : [[String : String]] = [[:]]
   
    var appDelegate = AppDelegate()
    var home = Localizator.instance.localize(string: "key_tittleHome")
    var customer = Localizator.instance.localize(string: "key_buttonCustomer")
    var configuration = Localizator.instance.localize(string: "key_buttonConfiguration")
    var endOfDay = Localizator.instance.localize(string: "key_buttonEndOfDay")
    var orders = Localizator.instance.localize(string: "key_buttonOrders")
    var management = Localizator.instance.localize(string: "key_buttonManagement")
    var logOut = Localizator.instance.localize(string: "key_logOut")
  
    
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
        
           menuDictArray = [["name" : "","imageName" : "", "category" : "-1"], ["name" : home, "imageName" : "homeBlack_icon","category" : "-1"], ["name" : orders, "imageName" : "orderBlack_icon", "category" : "1"], ["name" : endOfDay, "imageName" : "eodBlack_icon", "category" : "3"],["name" : management, "imageName" : "managementBlack_icon", "category" : "2"], ["name" : configuration, "imageName" : "configurationBlack_icon", "category" : "-1"], ["name" : customer, "imageName" : "customerImg1", "category" : "-1"], ["name" : logOut, "imageName" : "logoutBlack_icon", "category" : "-1"]]
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

            userProfileCell.labelFirstName.text = self.userDefaultsDictionary["firstName"]! + " " + self.userDefaultsDictionary["lastName"]!
        
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
        
        if(nameFetch == orders){
            
            let OrderVC = storyBord.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                        self.navigationController?.pushViewController(OrderVC, animated: true)
                        OrderVC.title = orders
        }
            
        else if(nameFetch == home){
            
            let homeVC = storyBord.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
           
        }
            
        else if(nameFetch == endOfDay){
            
            let eodVC = storyBord.instantiateViewController(withIdentifier: "EndOfDayViewController") as! EndOfDayViewController
            self.navigationController?.pushViewController(eodVC, animated: true)
            eodVC.title = endOfDay
            
        }
            
        else if(nameFetch == management){
            
            let mgntVC = storyBord.instantiateViewController(withIdentifier: "ManagementViewController") as! ManagementViewController
            self.navigationController?.pushViewController(mgntVC, animated: true)
            mgntVC.title = management
        }
            
        else if(nameFetch == configuration){
            
            let configVC = storyBord.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
            self.navigationController?.pushViewController(configVC, animated: true)
            configVC.title = configuration
        }
            
        else if(nameFetch == customer){
            
            let customerVC = storyBord.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            self.navigationController?.pushViewController(customerVC, animated: true)
            customerVC.title = customer
        }
            
        else if(nameFetch == logOut){
            
            let alertController = UIAlertController(title: logOut, message: Localizator.instance.localize(string: "key_logOutMessage"), preferredStyle: .alert)
               let alertControllerNevermind = UIAlertController(title: Localizator.instance.localize(string: "key_logOutTittleNevermind"), message: Localizator.instance.localize(string: "key_logOutCancel"), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: logOut, style: .default, handler: {
                alert -> Void in
              

                self.dismiss(animated: true, completion: {
                    
                    self.userDefaultsDictionary.removeValue(forKey: "dataDictionary")
                    print("data empty\(String(describing:    self.userDefaultsDictionary.removeValue(forKey: "dataDictionary")))")
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                    let  navVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialNavVC") as! UINavigationController
                    UserDefaults.standard.removeObject(forKey: "dataDictionary")
                    navVC.setViewControllers([viewController], animated: false)
                    self.appDelegate.window?.rootViewController = navVC
                    self.dismissModalStack()
                })
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            alertController.view.tintColor = UIColor.blue

            
           
            let cancelAction  = UIAlertAction(title:Localizator.instance.localize(string: "key_logOutTittleNevermind"), style: .destructive, handler: {
                alert -> Void in
              
                   alertControllerNevermind.dismiss(animated: true, completion: nil)
                
            })
            alertController.addAction(cancelAction)
          self.present(alertControllerNevermind, animated: true, completion: nil)
  
        }
        else if(indexPath.row == 0){
            
            let signUpVC = storyBord.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(signUpVC, animated: true)
            let scene = SceneType.SideMenuScene
            signUpVC.sceneType = scene
            signUpVC.firstName = userDefaultsDictionary["firstName"]!
            signUpVC.lastName = userDefaultsDictionary["lastName"]!
            signUpVC.email = userDefaultsDictionary["userEmail"]!
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
