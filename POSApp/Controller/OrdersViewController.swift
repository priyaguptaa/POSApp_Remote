//
//  OrdersViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 24/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
// set delegate here
protocol PopUpViewControllerDelegate: class {
    
    func changeBackgroundColor(_ color: UIColor?)
    
}

class OrdersViewController: UIViewController,PopUpViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func changeBackgroundColor(_ color: UIColor?) {
        buttonReservation.backgroundColor = UIColor.black
    }
    var floorOneImageArray : [String] = [""]
    var floorOneNameArray : [String] = [""]
    var hallImageArray : [String] = [""]
    var hallNameArray : [String] = [""]
    var balconeyImageArray : [String] = [""]
    var balconeyNameArray : [String] = [""]
    var floorTwoImageArray : [String] = [""]
    var floorTwoNameArray : [String] = [""]
    var fetchingFloorNameArray : [String] = [""]
    var textFieldAddFloor = UITextField()
    var tempArray :[String ] = []
    
    @IBOutlet weak var buttonAddFloor: DesignButton!
    @IBOutlet weak var collectionViewOrder: UICollectionView!
    @IBOutlet weak var segmentControlOrder: UISegmentedControl!
    @IBOutlet weak var buttonReservation: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set segment font size
        let attribute = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 25.0)!, forKey: NSFontAttributeName as NSCopying)
        segmentControlOrder.setTitleTextAttributes(attribute as [NSObject : AnyObject] , for: .normal)
     
        setCustomColor()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setCustomColor(){
        
        buttonReservation.backgroundColor = UIColor.customRed
        
    }
    
    // set nib register for collection view
    func setupView()
    {
        self.collectionViewOrder.delegate = self
        self.collectionViewOrder.dataSource = self
    
        self.collectionViewOrder.register(UINib(nibName:"OrderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OrderCollectionViewCell")
        
        floorOneNameArray = ["place1","place2", "place3" , "place4","place5","place6", "place7","place8"]
        floorOneImageArray = ["place1","place2", "place3" , "place4","place5","place6", "place7","place8"]
        hallNameArray =   ["place1","place2", "place3" , "place4","place5","place6", "place7","place8"]
        hallImageArray = ["place1","place2", "place3" , "place4","place5","place6", "place7","place8"]
        balconeyNameArray = ["place1","place2", "place3" , "place4","place5","place6"]
        balconeyImageArray = ["place1","place2", "place3" , "place4","place5","place6"]
        floorTwoNameArray = ["place1","place2", "place3" , "place4","place5"]
        floorTwoImageArray = ["place1","place2", "place3" , "place4","place5"]
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArray.count
       
    }
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCollectionViewCell", for: indexPath) as! OrderCollectionViewCell
           collectionCell.imageViewFloor.image = UIImage.init(named: tempArray[indexPath.row])
            return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionViewOrder.cellForItem(at: indexPath) as! OrderCollectionViewCell
        if selectedCell.isSelected == true {
            selectedCell.imageViewFloor.layer.borderColor = UIColor.red.cgColor
            selectedCell.imageViewFloor.layer.borderWidth = 2.0
           
            let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
            popOverVc.delegate = self
            self.addChildViewController(popOverVc)
            popOverVc.view.frame = self.view.frame
            self.view.addSubview(popOverVc.view)
            popOverVc.didMove(toParentViewController: self)
            self.buttonReservation.backgroundColor = UIColor.brown
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! OrderCollectionViewCell
        selectedCell.imageViewFloor.layer.borderColor = UIColor.clear.cgColor
        selectedCell.imageViewFloor.layer.borderWidth = 2.0
        
    }
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
     
        switch (sender.selectedSegmentIndex) {
        case 0:
                self.tempArray = self.hallImageArray
            break;
        case 1:
        self.tempArray = self.balconeyImageArray
            break;
        case 2:
            self.tempArray = self.floorOneImageArray
            break;
        case 3:
            self.tempArray = self.floorTwoImageArray
            break;
        default:
            self.tempArray = self.hallImageArray
            break
        }
       self.collectionViewOrder.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func buttonAddFoorAction(_ sender: Any) {
//        let alertController = UIAlertController(title: "Add New Name", message: "Enter Floor Which you want!!", preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
//            alert -> Void in
//            
//            self.textFieldAddFloor = alertController.textFields![0] as UITextField
//            if (self.textFieldAddFloor.text == ""){
//                let alertController = UIAlertController(title: "Error Message:(", message: "you are creating blank floor :(", preferredStyle: .alert)
//                
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
//                    alert -> Void in
//                })
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: nil)
//                
//            }
//            else {
//               
//                print("listName \(self.textFieldAddFloor.text)")
//            
//            }
//            
//            
//        })
//        
//        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: {
//            alert -> Void in
//            print("cancel")
//            
//        })
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter First Name"
//        }
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }

    @IBAction func buttonReservationAction(_ sender: Any) {
        if buttonReservation.isSelected{
         buttonReservation.backgroundColor = UIColor.white
        }
        else{
        buttonReservation.backgroundColor = UIColor.blue
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
