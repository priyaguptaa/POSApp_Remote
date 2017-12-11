//
//  OrderItemViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 30/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class OrderItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOrderItem: UITableView!
    @IBOutlet weak var tableViewMenuItem: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    func setUpView(){
        
        
    tableViewOrderItem.delegate = self
    tableViewOrderItem.dataSource = self
    tableViewMenuItem.delegate = self
    tableViewMenuItem.dataSource = self
        
        
    self.tableViewOrderItem.register(UINib(nibName: "OrderItemTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderItemTableViewCell")
    self.tableViewMenuItem.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuItemTableViewCell")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (tableView == tableViewOrderItem) && tableView == tableViewMenuItem {
            
        }
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewOrderItem {
            return 5
        }
        else if (tableView == tableViewMenuItem) {
            return 6
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if(tableView == tableViewOrderItem)
        {
            let orderItemCell = self.tableViewOrderItem.dequeueReusableCell(withIdentifier: "OrderItemTableViewCell", for: indexPath) as! OrderItemTableViewCell

//            let firstImageCollection = imagesArray[indexPath.row]
//            firstCollectionCell.firstCollectionImg.image = UIImage(named: firstImageCollection)
            return orderItemCell
        }
            
        else
        {
            let menuItemCell = self.tableViewMenuItem.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as! MenuItemTableViewCell

//            let myImage = collectionImageArray[indexPath.row]
//            collectionCell.collectionImageView.image = UIImage(named: myImage)
            return menuItemCell
        }
    
        
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
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
