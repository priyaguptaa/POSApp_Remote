//
//  EmployeeViewController.swift
//  POSApp
//
//  Created by PriyaMac on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
protocol AddNewEmployeePopUpViewControllerDelegate: class {
    
    func loadEmployeeDetail()
    func loadEmployeeUpdateDetail()
    
}

class EmployeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,AddNewEmployeePopUpViewControllerDelegate {
    
    
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setLocalization()
        // Do any additional setup after loading the view.
    }
    func setUpView(){
        
        tableViewEmployee.delegate = self
        tableViewEmployee.dataSource = self
        tableViewEmployee.register(UINib(nibName:"EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        
    }
    
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
        let scene = SceneType.addEmpolyeeScene
        popOverVc.sceneType = scene
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
    }
    
    @IBAction func actionCloseButton(_ sender: Any) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let employeeCell = tableViewEmployee.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as! EmployeeTableViewCell
        let objEmployee = employeeListArray[indexPath.row]
        
        employeeCell.labelName.text = objEmployee.EmployeeName
        employeeCell.labelPassword.text = objEmployee.password
        employeeCell.labelRole.text = objEmployee.role
        employeeCell.labelContact.text = objEmployee.contact
        employeeCell.labelAddress.text = objEmployee.address
        employeeCell.labelRate.text = objEmployee.rate
        employeeCell.labelHourly.text = objEmployee.hourly
        return employeeCell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objEmployee = employeeListArray[indexPath.row]
        
        let employeeInfoDict:[String:String] = ["name":objEmployee.EmployeeName,"password":objEmployee.password,"role":objEmployee.role,"contact":objEmployee.contact,"address":objEmployee.address,"rate":objEmployee.rate,"hourly":objEmployee.hourly]
        UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
        let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
        print(result!)
        
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
    override func viewWillAppear(_ animated: Bool) {
        
        self.employeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewEmployee.reloadData()
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
