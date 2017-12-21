//
//  ConfigurationViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by  priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var buttonPrint: DesignButton!
    @IBOutlet weak var buttonMenu: DesignButton!
    @IBOutlet weak var buttonTable: DesignButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomColor()
        setCustomLanguageValue()
        // Do any additional setup after loading the view.
    }

    // set custom color
    func setCustomColor(){
        
    buttonTable.backgroundColor = UIColor.customLightBlue
    buttonMenu.backgroundColor = UIColor.customLightBlue
    buttonPrint.backgroundColor = UIColor.customLightBlue
        
    }
    
    func setCustomLanguageValue(){
        
        
        buttonPrint.setTitle(Localizator.instance.localize(string: "key_buttonPrint"), for: .normal)
        buttonMenu.setTitle(Localizator.instance.localize(string: "key_buttonMenu"), for: .normal)
        buttonTable.setTitle(Localizator.instance.localize(string: "key_buttonTable"), for: .normal)
       
    }

    
    @IBAction func buttonTableAction(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let addFloorTableVC = storyBord.instantiateViewController(withIdentifier: "AddTablesFloorsViewController") as! AddTablesFloorsViewController
        self.navigationController?.pushViewController(addFloorTableVC, animated: true)
        
    }
    
  
    @IBAction func buttonMenuAction(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let MenuListVC = storyBord.instantiateViewController(withIdentifier: "MenuListViewController") as! MenuListViewController
        self.navigationController?.pushViewController(MenuListVC, animated: true)
        MenuListVC.title = "Menus"
        
    }
    
    @IBAction func buttonPrintAction(_ sender: Any) {
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
