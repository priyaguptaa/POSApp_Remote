//
//  PopUpViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 28/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var buttonClose: DesignButton!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var buttonSave: DesignButton!
    @IBOutlet weak var textFieldContact: DesignableTextField!
    @IBOutlet weak var textFieldDate: DesignableTextField!
    @IBOutlet weak var textFieldName: DesignableTextField!
    weak var delegate: PopUpViewControllerDelegate?
    var dateFetch = ""
    let datePickerView:UIDatePicker = UIDatePicker()
    
    // MARK:- view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        doneButtonAdd()
        setCustomColor()
        textFieldPlaceHolder()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Helper function
    
    func setCustomColor(){
        
        buttonSave.backgroundColor = UIColor.customRed
        buttonClose.backgroundColor = UIColor.customRed
        self.viewPopUp.backgroundColor = UIColor.customLightGray
        self.textFieldName.textColor = UIColor.customblack
        self.textFieldContact.textColor = UIColor.customblack
        self.textFieldDate.textColor = UIColor.customblack
        
    }
    
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldName, currentPlaceholderText: Localizator.instance.localize(string: "key_enterYourName"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldContact, currentPlaceholderText: Localizator.instance.localize(string: "key_contactPeople"))
         createAttributedPlacedholderToTextField(currentTextField: textFieldDate, currentPlaceholderText: Localizator.instance.localize(string: "key_dateWithTime"))
        
    }
    
    func setLocalization(){
       
        buttonSave.setTitle(Localizator.instance.localize(string: "key_buttonSave"), for: .normal)
        buttonClose.setTitle(Localizator.instance.localize(string: "key_buttonClose"), for: .normal)
    
    }
    
    // MARK:- Button actions
    
    @IBAction func buttonCloseAction(_ sender: Any) {
        self.view.removeFromSuperview()
        delegate?.changeBackgroundColor(UIColor.black)
    }
    
    @IBAction func buttonSaveAction(_ sender: Any) {
    }
    @IBAction func textFieldDateAction(_ sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = DateFormatter.Style.full
 //       dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.textFieldDate.text = dateFormatter.string(from: sender.date)
    }
    func doneButtonAdd()
    {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Month", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PopUpViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PopUpViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Select a  date"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        textFieldDate.inputAccessoryView = toolBar
        
        
    }
    func donePressed(_ sender: UIBarButtonItem) {
        
        textFieldDate.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.medium
        
        dateformatter.timeStyle = DateFormatter.Style.none
        
        textFieldDate.text = dateformatter.string(from: Date())
        
        textFieldDate.resignFirstResponder()
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
