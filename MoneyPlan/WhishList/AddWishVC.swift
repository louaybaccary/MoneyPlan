//
//  AddWishVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/13/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class AddWishVC: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource , UICollectionViewDataSource, UICollectionViewDelegate{
    var pickerData: [String] = [String]()
       let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    var Category = ""
    var Image = ""
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var moneyLabel: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
 
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Clothes", "Medical", "Technology", "Food", "Luxuries", "Other"]

       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wish", for: indexPath)
        
        let image = cell.viewWithTag(1) as! UIImageView
        
        image.image = UIImage (named: Images[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Image = Images[indexPath.item]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Category = pickerData[row]
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    @IBAction func AddBtn(_ sender: Any) {
        let name = nameLabel.text
        let money = moneyLabel.text
        API.AddTarget(username: "1", name: name!, money: money!, category: Category, image: Image,type: "wish")
        print(Category+Image)
       
    }


}
