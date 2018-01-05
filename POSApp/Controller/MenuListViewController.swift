//
//  MenuListViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 01/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController {
    
    // MARK:- Variable declaration
    
    @IBOutlet weak var labelBottomCategory: UILabel!
    @IBOutlet weak var labelBelowMenu: UILabel!
    @IBOutlet weak var buttonMenuGst: DesignButton!
    @IBOutlet weak var buttonMenuSpecial: DesignButton!
    @IBOutlet weak var labelBelowMenuSpecial: UILabel!
    @IBOutlet weak var labelBelowMenuGst: UILabel!
    @IBOutlet weak var textFieldBelowMenuPrice: UITextField!
    @IBOutlet weak var labelBelowMenuPrice: UILabel!
    @IBOutlet weak var textFieldBelowMenu: UITextField!
    @IBOutlet weak var labelBelowMenuName: UILabel!
    @IBOutlet weak var labelAboveMenuGst: DesignableLabel!
    @IBOutlet weak var labelAboveMenuSpecial: DesignableLabel!
    @IBOutlet weak var labelAboveMenuPrice: DesignableLabel!
    @IBOutlet weak var labelAboveMenuName: DesignableLabel!
    @IBOutlet weak var labelMenuNo: DesignableLabel!
    @IBOutlet weak var labelMenuItems: UILabel!
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var labelBelowCategory: UILabel!
    @IBOutlet weak var labelAboveCategory: UILabel!
    @IBOutlet weak var viewMenuItem: DesignableView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var tableViewMenuItems: UITableView!
    @IBOutlet weak var tableViewCategory: UITableView!
    @IBOutlet weak var textFieldCategoryName: UITextField!
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomLanguageValue()
        setCustomColor()
        setUpView()
        self.title = Localizator.instance.localize(string: "key_menu")
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Helper function
    
    func setCustomLanguageValue(){
        
        labelAboveCategory.text = Localizator.instance.localize(string: "key_category")
        labelBelowCategory.text = Localizator.instance.localize(string: "key_category")
        labelBottomCategory.text = Localizator.instance.localize(string: "key_category")
        labelCategoryName.text = Localizator.instance.localize(string: "key_name")
        labelBelowMenu.text = Localizator.instance.localize(string: "key_menu")
        labelMenuItems.text = Localizator.instance.localize(string: "key_menuItems")
        labelMenuNo.text = Localizator.instance.localize(string: "key_no")
        labelAboveMenuName.text = Localizator.instance.localize(string: "key_name")
        labelAboveMenuSpecial.text = Localizator.instance.localize(string: "key_special")
        labelAboveMenuGst.text = Localizator.instance.localize(string: "key_gst")
        labelAboveMenuPrice.text = Localizator.instance.localize(string: "key_price")
        labelBelowMenuName.text = Localizator.instance.localize(string: "key_name")
        labelBelowMenuPrice.text = Localizator.instance.localize(string: "key_price")
        labelBelowMenuSpecial.text = Localizator.instance.localize(string: "key_special")
        labelBelowMenuGst.text = Localizator.instance.localize(string: "key_gst")
 
    }
    
    // nib register for menu and category cell
    func setUpView(){
        
        tableViewCategory.delegate = self as? UITableViewDelegate
        tableViewMenuItems.delegate = self as? UITableViewDelegate
        tableViewCategory.dataSource = self
        tableViewMenuItems.dataSource = self
        tableViewMenuItems.register(UINib(nibName: "MenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuListTableViewCell")
        tableViewCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    
    func setCustomColor(){
    
        self.viewCategory.backgroundColor = UIColor.customblack
        self.viewMenuItem.backgroundColor = UIColor.lightGray
        
    }
    
    @IBAction func buttonActionMenuSpecial(_ sender: Any) {
    }
    
    @IBAction func buttonActionMenuGst(_ sender: Any) {
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

//MARK:- Table view datasource

extension MenuListViewController: UITableViewDataSource{
    
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
    
   
}
extension MenuListViewController: UICollectionViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
}
