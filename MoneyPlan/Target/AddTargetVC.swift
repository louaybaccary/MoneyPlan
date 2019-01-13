//
//  AddTargetVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/27/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit

class AddTargetVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , UICollectionViewDataSource, UICollectionViewDelegate{

    var Category = ""
    var Image = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Clothes", "Medical", "Technology", "Food", "Luxuries", "Other"]
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "target", for: indexPath)
        
        let image = cell.viewWithTag(1) as! UIImageView
        
        image.image = UIImage (named: Images[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Image = Images[indexPath.item]
    }
    let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textMoney: UITextField!
 
    @IBAction func btnAdd(_ sender: Any) {
        let name = textName.text
        let money = textMoney.text
        API.AddTarget(username: "1", name: name!, money: money!, category: Category, image: Image,type: "target")
        print(Category+Image)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Target", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TargetPage") as! ShowTargetVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
   
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
}
