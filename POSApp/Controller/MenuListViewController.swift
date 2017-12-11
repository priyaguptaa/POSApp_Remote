//
//  MenuListViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 01/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewMenuItem: DesignableView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var tableViewMenuItems: UITableView!
    @IBOutlet weak var tableViewCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomColor()
        setUpView()
        
        // Do any additional setup after loading the view.
    }
   
    // nib register for menu and category cell
    func setUpView(){
        
    tableViewCategory.delegate = self
    tableViewMenuItems.delegate = self
    tableViewCategory.dataSource = self
    tableViewMenuItems.dataSource = self
    tableViewMenuItems.register(UINib(nibName: "MenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuListTableViewCell")
    tableViewCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    
    func setCustomColor(){
    
        self.viewCategory.backgroundColor = UIColor.customblack
        self.viewMenuItem.backgroundColor = UIColor.lightGray
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (tableView == tableViewCategory) && tableView == tableViewMenuItems {
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewCategory {
            return 5
        }
        else if (tableView == tableViewMenuItems) {
            return 6
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tableViewCategory)
        {
        let categoryCell = tableViewCategory.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
              return categoryCell
        }
        else{
        
            let menuListCell = tableViewMenuItems.dequeueReusableCell(withIdentifier: "MenuListTableViewCell") as! MenuListTableViewCell
            return menuListCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
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
