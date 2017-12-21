//
//  EmployeeViewController.swift
//  POSApp
//
//  Created by PriyaMac on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelRate: UILabel!
    
    @IBOutlet weak var labelHourly: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var buttonClose: DesignButton!
    @IBOutlet weak var buttonEdit: DesignButton!
    @IBOutlet weak var buttonAddNewEmployee: DesignButton!
    

    @IBOutlet weak var tableViewEmployee: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    func setUpView(){
        
        tableViewEmployee.delegate = self
        tableViewEmployee.dataSource = self
        tableViewEmployee.register(UINib(nibName:"EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        
    }
    
    @IBAction func actionAddEmployeeButton(_ sender: Any) {
    }
    @IBAction func actionEditButton(_ sender: Any) {
    }
    
    @IBAction func actionCloseButton(_ sender: Any) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let employeeCell = tableViewEmployee.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as! EmployeeTableViewCell
        return employeeCell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
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
