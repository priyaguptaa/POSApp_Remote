//
//  AddTablesFloorsViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 06/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class AddTablesFloorsViewController: UIViewController {
    
    // MARK:- Variable declaration
    
    @IBOutlet weak var buttonRemoveTable: UIButton!
    @IBOutlet weak var buttonAddTable: UIButton!
    @IBOutlet weak var buttonRemoveFloor: UIButton!
    @IBOutlet weak var buttonAddFloor: UIButton!
    @IBOutlet weak var collectionViewAddTable: UICollectionView!
    @IBOutlet weak var collectionViewAddFloor: UICollectionView!
    
    var arrayAddFloor : [String] = [Localizator.instance.localize(string: "key_hall"), Localizator.instance.localize(string: "key_balconey")]
    var imageArray : [String] = []
    var arrayAddTable : [String] = ["tableWithWheel_img", "4chairTable_img", "candleTable", "CoupleTable_img", "partyTable_img", "tableTree_img", "tableWithWheel_img", "tableYellow_img"]
    var i = 1
    var indexTable = 0
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setLocalization()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper function
    
    func setUpView(){
        
    collectionViewAddFloor.delegate = self
    collectionViewAddFloor.dataSource = self
    collectionViewAddTable.delegate = self
    collectionViewAddTable.dataSource = self
    collectionViewAddFloor.register(UINib(nibName: "AddFloorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddFloorCollectionViewCell")
        collectionViewAddTable.register(UINib(nibName: "AddTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddTableCollectionViewCell")
        
    }
    
    func setLocalization(){
        
        self.buttonAddFloor.setTitle(Localizator.instance.localize(string: "key_addFloor"), for: .normal)
        self.buttonRemoveFloor.setTitle(Localizator.instance.localize(string: "key_removeFloor"), for: .normal)
        self.buttonAddTable.setTitle(Localizator.instance.localize(string: "key_addTable"), for: .normal)
        self.buttonRemoveTable.setTitle(Localizator.instance.localize(string: "key_removeTable"), for: .normal)
    }
    
   
    // MARK:- Button Actions
    
    @IBAction func buttonAddFloorAction(_ sender: Any) {
       
        let floorString = Localizator.instance.localize(string: "key_floor") +  "\(i)"
        i += 1
        arrayAddFloor.append(floorString)
        print("printed floor name \(floorString)")
        collectionViewAddFloor.reloadData()
        
    }
    
    
    @IBAction func removeFloorButtonAction(_ sender: Any) {
   
        if(arrayAddFloor.count > 2){
            i = i-1
        arrayAddFloor.removeLast()
        collectionViewAddFloor.reloadData()
        }
        else {
            
            print("u r doing wrong")
            showDefaultAlertViewWith(alertTitle:  Localizator.instance.localize(string: "key_errorMsg"), alertMessage:  Localizator.instance.localize(string: "key_deleteFloor") , okTitle:  Localizator.instance.localize(string: "key_ok") , currentViewController: self)
           // key_errorMsg
        }
        
         }
    
    
    @IBAction func actionButtonAddTable(_ sender: Any) {
        
        if (indexTable == 0 || indexTable < arrayAddTable.count - 1) {
            imageArray.append(arrayAddTable[indexTable])
            indexTable += 1
            collectionViewAddTable.reloadData()
            
    }
        else {
            print("error")
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage:  Localizator.instance.localize(string: "key_dontHaveTable"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
        }
    }
    @IBAction func actionButtonRemoveTable(_ sender: Any) {
        
        if(imageArray.count > 0){
            imageArray.removeLast()
              indexTable = indexTable  - 1
            collectionViewAddTable.reloadData()
        }
        else {
            
            print("u r doing wrong")
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "key_errorMsg"), alertMessage: Localizator.instance.localize(string: "key_removeAllTable"), okTitle: Localizator.instance.localize(string: "key_ok"), currentViewController: self)
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
//MARK:- Collection view datasource
extension AddTablesFloorsViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionViewAddFloor != nil) && collectionView == collectionViewAddTable {
            
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewAddFloor) {
            return arrayAddFloor.count
        }
        else {
            return imageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewAddFloor){
            let addFloorCollectionCell = collectionViewAddFloor.dequeueReusableCell(withReuseIdentifier: "AddFloorCollectionViewCell", for: indexPath) as! AddFloorCollectionViewCell
            addFloorCollectionCell.labelAddFloor.text = arrayAddFloor[indexPath.row]
            return addFloorCollectionCell
        }
        else
        {
            let addTableCollectionCell = collectionViewAddTable.dequeueReusableCell(withReuseIdentifier: "AddTableCollectionViewCell", for: indexPath) as! AddTableCollectionViewCell
            let collectionImage = imageArray[indexPath.row]
            addTableCollectionCell.imageViewAddTable.image = UIImage(named: collectionImage)
            
            return addTableCollectionCell
        }
    }
}
// MARK Collection view delegate
extension AddTablesFloorsViewController: UICollectionViewDelegate {
    
}
