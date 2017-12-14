//
//  EmployeeViewController.swift
//  POSApp
//
//  Created by PriyaMac on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
