//
//  CustomerViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Variable declaration
    
    @IBOutlet weak var buttonSubmit: DesignButton!
    @IBOutlet weak var labelRoll: UILabel!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewDropDown: UITableView!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldCustmorContact: UITextField!
    @IBOutlet weak var buttonRoll: UIButton!
    @IBOutlet weak var viewLastName: DesignableView!
    @IBOutlet weak var viewContactNo: DesignableView!
    @IBOutlet weak var viewFirstName: DesignableView!
    @IBOutlet weak var viewRoll: DesignableView!
    var rollArray = ["val1", "val2", "val3", "val4", "val5", "val6", "val7"]
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocalization()
        setTextFieldDelegate()
        setCustomColor()
    
        tableViewDropDown.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper Methods
    
    func setCustomColor(){
    
    self.viewFirstName.backgroundColor = UIColor.customLightBlue
    self.viewLastName.backgroundColor = UIColor.customLightBlue
    self.viewContactNo.backgroundColor = UIColor.customLightBlue
    self.viewRoll.backgroundColor = UIColor.customLightBlue
        
    }
    
    func setLocalization(){
        
    textFieldFirstName.text = Localizator.instance.localize(string: "key_firstName")
    textFieldLastName.text = Localizator.instance.localize(string: "key_lastName")
    textFieldCustmorContact.text = Localizator.instance.localize(string: "key_enterContact")
    buttonRoll.setTitle(Localizator.instance.localize(string: "key_selectRoll"), for: .normal)
    buttonSubmit.setTitle(Localizator.instance.localize(string: "key_buttonSubmit"), for: .normal)
    labelFirstName.text = Localizator.instance.localize(string: "key_firstNameLabel")
    labelLastName.text = Localizator.instance.localize(string: "key_lastNameLabel")
    labelRoll.text = Localizator.instance.localize(string: "key_roll")
    labelContact.text = Localizator.instance.localize(string: "key_contactNo")
        
    }
    
    func setTextFieldDelegate(){
        
        textFieldFirstName.delegate = self
        textFieldLastName.delegate = self
        textFieldCustmorContact.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldFirstName.resignFirstResponder()
        textFieldLastName.resignFirstResponder()
        textFieldCustmorContact.resignFirstResponder()
        return true
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentInset = contentInset
        
    }
    
    // MARK:- Button actions
    
    @IBAction func buttonActionSubmit(_ sender: Any) {
    }

    @IBAction func buttonRollAction(_ sender: Any) {
        
        // hiding and unhiding
        tableViewDropDown.isHidden = !tableViewDropDown.isHidden
        
    }
    
}
// MARK:- Tabel view Datasource

extension CustomerViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rollArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewDropDown.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rollArray[indexPath.row]
        return cell
        
    }
}
// MARK:- Table view Delegate
extension CustomerViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableViewDropDown.cellForRow(at: indexPath)
        buttonRoll.setTitle(cell?.textLabel?.text, for: .normal)
        self.tableViewDropDown.isHidden = true
        
    }
}
