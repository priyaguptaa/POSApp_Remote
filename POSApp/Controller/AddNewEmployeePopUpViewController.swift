//
//  AddNewEmployeePopUpViewController.swift
//  POSApp
//
//  Created by PriyaMac on 21/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class AddNewEmployeePopUpViewController: UIViewController, UITextFieldDelegate {

    // MARK:- Variable declaration
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var textFieldHourly: UITextField!
    @IBOutlet weak var textFieldRate: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldContact: UITextField!
    @IBOutlet weak var textFieldRole: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var viewPopUp: UIView!
    
     var userDefaultsDictionary  : [String:String] = [:]
    var sceneType : SceneType? = nil
    weak var delegate: AddNewEmployeePopUpViewControllerDelegate?
    
    // MARK:- View life cycle methods
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        setTextFieldDelegate()
        textFieldPlaceHolder()
        sceneChecking()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
      


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper function
    
    func sceneChecking(){
        
        let userDefaults = UserDefaults.standard
        if  (userDefaults.value(forKey: "employeeInfoDict") as? [String:String]) != nil {
            self.userDefaultsDictionary = userDefaults.value(forKey: "employeeInfoDict") as! [String:String]
        }
        else{
            print("error")
        }
            switch sceneType {
        case .addEmpolyeeScene?:
            self.buttonSave.setTitle( Localizator.instance.localize(string: "key_buttonSave"), for: .normal)
            self.buttonClose.setTitle( Localizator.instance.localize(string: "key_buttonClose"), for: .normal)
            break
        case .editEmployeeScene?:
            self.textFieldName.text = userDefaultsDictionary["name"]
            self.textFieldPassword.text = userDefaultsDictionary["password"]
            self.textFieldRole.text = userDefaultsDictionary["role"]
            self.textFieldContact.text = userDefaultsDictionary["contact"]
            self.textFieldAddress.text = userDefaultsDictionary["address"]
            self.textFieldRate.text = userDefaultsDictionary["rate"]
            self.textFieldHourly.text = userDefaultsDictionary["hourly"]
            textFieldName.isUserInteractionEnabled = false
            self.buttonSave.setTitle( Localizator.instance.localize(string: "key_update"), for: .normal)
            self.buttonClose.setTitle( Localizator.instance.localize(string: "key_buttonClose"), for: .normal)
            break
        default : break
        }
    }
    
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldName, currentPlaceholderText: Localizator.instance.localize(string: "key_enterName"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: Localizator.instance.localize(string: "key_password"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldRole, currentPlaceholderText: Localizator.instance.localize(string: "key_enterRole"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldContact, currentPlaceholderText: Localizator.instance.localize(string: "key_enterContact"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldAddress, currentPlaceholderText: Localizator.instance.localize(string: "key_enterAddress"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldRate, currentPlaceholderText: Localizator.instance.localize(string: "key_enterRate"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldHourly, currentPlaceholderText: Localizator.instance.localize(string: "key_enterHourly"))
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        var info = notification.userInfo!
        let kbSize: CGSize = ((info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size)
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldName.resignFirstResponder()
        textFieldContact.resignFirstResponder()
        textFieldRole.resignFirstResponder()
        textFieldRate.resignFirstResponder()
        textFieldAddress.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldHourly.resignFirstResponder()
        
        return true
        
    }
    
    func setTextFieldDelegate(){
        
        textFieldName.delegate = self
        textFieldContact.delegate = self
        textFieldRole.delegate = self
        textFieldRate.delegate = self
        textFieldAddress.delegate = self
        textFieldPassword.delegate = self
        textFieldHourly.delegate = self
        
    }
    
    func checkFieldsValidation(){
        
        if ((textFieldName.text != "") && (textFieldPassword.text != "")&&(textFieldContact.text != "")&&(textFieldAddress.text != "")&&(textFieldRole.text != "")&&(textFieldRate.text != "")&&(textFieldHourly.text != "")){
            DBManager.shared.insertIntoPOSEmployee(name: self.textFieldName.text!, pwd: textFieldPassword.text!, contact: textFieldRole.text!, address: textFieldContact.text!, role: textFieldAddress.text!, rate: textFieldRate.text!, hourly: textFieldHourly.text!)
            let alertController = UIAlertController(title: Localizator.instance.localize(string: "key_buttonSave"), message: Localizator.instance.localize(string: "key_insertedMsg"), preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizator.instance.localize(string: "key_ok"), style: .default, handler: {
                alert -> Void in
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if ((textFieldName.text == "") && (textFieldPassword.text == "")&&(textFieldContact.text == "")&&(textFieldAddress.text == "")&&(textFieldRole.text == "")&&(textFieldRate.text == "")&&(textFieldHourly.text == "")) {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_signUpEmptyAlertTittle"), alertMessage: Localizator.instance.localize(string: "key_signUpEmptyAlertMessage"), okTitle: Localizator.instance.localize(string: "key_Discard"), currentViewController: self)
        }
        else if ((self.textFieldPassword.text == "") && (self.textFieldName.text != "") && (self.textFieldRole.text != "") && (self.textFieldContact.text != "")) {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_signUpEmptyAlertTittle"), alertMessage: Localizator.instance.localize(string: "key_SignUpEmptyPasswordTittle"), okTitle: Localizator.instance.localize(string: "key_Discard"), currentViewController: self)
        }
        else if (textFieldName.text  == "")  {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_signUpEmptyAlertTittle"), alertMessage: Localizator.instance.localize(string: "key_emptyAlertName"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
        }
        else if (textFieldPassword.text  == "") {
            
            showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "key_signUpEmptyAlertTittle"), alertMessage: Localizator.instance.localize(string: "key_SignUpEmptyPasswordTittle"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
        }
            
        else if(self.textFieldContact.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "key_emptyContact"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldAddress.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "key_emptyAddress"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldRole.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "key_emptyRole"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldRate.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "key_emptyRate"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldHourly.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertHourly"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
        else {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:Localizator.instance.localize(string: "key_alertMsg"), okTitle: Localizator.instance.localize(string: "key_dismiss"), currentViewController: self)
        }
    }
    
    // MARK:- Buttons actions
    
    @IBAction func actionSaveButton(_ sender: Any) {
        
        switch sceneType {
            
        case .addEmpolyeeScene?:
            //            let fetchEmployeeUpdateInfo = DBManager.shared.fetchEmployeeInfo()
            //            let employeeInfoDict:[String:String] = ["name":fetchEmployeeUpdateInfo[0].EmployeeName,"password":fetchEmployeeUpdateInfo[0].password,"role":fetchEmployeeUpdateInfo[0].role,"contact":fetchEmployeeUpdateInfo[0].contact,"address":fetchEmployeeUpdateInfo[0].address,"rate":fetchEmployeeUpdateInfo[0].rate,"hourly":fetchEmployeeUpdateInfo[0].hourly]
            //            UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
            //            let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
            //            print("reasult is \(result!)")
            checkFieldsValidation()
            delegate?.loadEmployeeDetail()
            
            break
            
        case .editEmployeeScene?:
            
            DBManager.shared.updateEmployeeInfo(name: self.textFieldName.text!, pwd: textFieldPassword.text!, contact: textFieldRole.text!, address: textFieldContact.text!, role: textFieldAddress.text!, rate: textFieldRate.text!, hourly: textFieldHourly.text!)
            
            let fetchEmployeeUpdateInfo = DBManager.shared.fetchEmployeeInfo()
            
            let employeeInfoDict:[String:String] = ["name":fetchEmployeeUpdateInfo[0].EmployeeName,"password":fetchEmployeeUpdateInfo[0].password,"role":fetchEmployeeUpdateInfo[0].role,"contact":fetchEmployeeUpdateInfo[0].contact,"address":fetchEmployeeUpdateInfo[0].address,"rate":fetchEmployeeUpdateInfo[0].rate,"hourly":fetchEmployeeUpdateInfo[0].hourly]
            
            UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
            
            let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
            print(result!)
            
            showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "key_success"), alertMessage:Localizator.instance.localize(string: "key_successMsg"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
            delegate?.loadEmployeeUpdateDetail()
            
            break
        default : break
        }
    }
    @IBAction func actionCloseButton(_ sender: Any) {
            //self.view.removeFromSuperview()
        switch sceneType {
        case .addEmpolyeeScene?:
            self.view.removeFromSuperview()
            
            break
        case .editEmployeeScene?:
            self.view.removeFromSuperview()
            
            
            break
        default : break
        }
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
