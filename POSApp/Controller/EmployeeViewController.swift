//
//  EmployeeViewController.swift
//  POSApp
//
//  Created by PriyaMac on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

//MARK:- Add protocol Here
protocol AddNewEmployeePopUpViewControllerDelegate: class {
    
    func loadEmployeeDetail()
    func loadEmployeeUpdateDetail()
    
}

class EmployeeViewController: UIViewController, AddNewEmployeePopUpViewControllerDelegate {
    
    // MARK:- Variable declarations
    
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
    var employeeListArray : [EmployeeInfo] = []
    
    // MARK:- Helper function
    func loadEmployeeDetail() {
        
        self.employeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewEmployee.reloadData()
        
    }
    func loadEmployeeUpdateDetail(){
        
        self.employeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewEmployee.reloadData()
    }
    
    func setLocalization(){
        
        self.buttonAddNewEmployee.setTitle(Localizator.instance.localize(string: "key_addNewEmployee"), for: .normal)
        self.buttonEdit.setTitle(Localizator.instance.localize(string: "key_buttonEdit"), for: .normal)
        self.buttonClose.setTitle(Localizator.instance.localize(string: "key_buttonClose"), for: .normal)
        
        labelName.text = Localizator.instance.localize(string: "key_name")
        labelPassword.text = Localizator.instance.localize(string: "key_labelPassword")
        labelRole.text = Localizator.instance.localize(string: "key_roll")
        labelContact.text = Localizator.instance.localize(string: "key_labelContact")
        labelRate.text = Localizator.instance.localize(string: "key_rate")
        labelAddress.text = Localizator.instance.localize(string: "key_labelAddress")
        labelHourly.text = Localizator.instance.localize(string: "key_hourly")
        
    }
    func setUpView(){
        
        tableViewEmployee.delegate = self
        tableViewEmployee.dataSource = self
        tableViewEmployee.register(UINib(nibName:"EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        
    }
    
    // MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setLocalization()
        self.tableViewEmployee.estimatedRowHeight = 100
        self.tableViewEmployee.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.employeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewEmployee.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Button Actions
    
    @IBAction func actionAddEmployeeButton(_ sender: Any) {
        
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeePopUpViewController") as! AddNewEmployeePopUpViewController
        popOverVc.delegate = self
        let scene = SceneType.addEmpolyeeScene
        popOverVc.sceneType = scene
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
        

    }
    @IBAction func actionEditButton(_ sender: Any) {
        
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeePopUpViewController") as! AddNewEmployeePopUpViewController
        
        popOverVc.delegate = self
        let scene = SceneType.editEmployeeScene
        popOverVc.sceneType = scene
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
        
    }
    
    @IBAction func actionCloseButton(_ sender: Any) {
        
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

//MARK:- TableView Delegate

extension EmployeeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objEmployee = employeeListArray[indexPath.row]
        
        let employeeInfoDict:[String:String] = ["name":objEmployee.EmployeeName,"password":objEmployee.password,"role":objEmployee.role,"contact":objEmployee.contact,"address":objEmployee.address,"rate":objEmployee.rate,"hourly":objEmployee.hourly]
        UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
        let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
        print("result is \(result!)")
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let objEmployee = employeeListArray[indexPath.row]
        if editingStyle == .delete {
            if DBManager.shared.deleteEmployeeInfo(withId:objEmployee.employeeId ) {
                employeeListArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
}

// MARK:- Tabelview Datasource

extension EmployeeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeeListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let employeeCell = tableViewEmployee.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as! EmployeeTableViewCell
        
        let objEmployee = employeeListArray[indexPath.row]
        if objEmployee != nil {
            employeeCell.labelName.text = objEmployee.EmployeeName
            employeeCell.labelPassword.text = objEmployee.password
            employeeCell.labelRole.text = objEmployee.role
            employeeCell.labelContact.text = objEmployee.contact
            employeeCell.labelAddress.text = objEmployee.address
            employeeCell.labelRate.text = objEmployee.rate
            employeeCell.labelHourly.text = objEmployee.hourly
            
        }
        else {
            
            
        }
        return employeeCell
    }
}
