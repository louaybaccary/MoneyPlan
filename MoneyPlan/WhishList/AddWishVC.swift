//
//  AddWishVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/13/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit
import SCLAlertView

class AddWishVC: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource , UICollectionViewDataSource, UICollectionViewDelegate{
    var pickerData: [String] = [String]()
       let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    var Category = "Clothes"
    var Image = "airplane"
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var moneyLabel: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
 
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wishPhoto")!)
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
        self.showSpinner(onView: self.view)
        if (self.isStringAnInt(string : money!)){
            
            API.AddTarget(username:API.getID(), name: name!, money: money!, category: Category, image: Image,type: "wish")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData5"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData6"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData7"), object: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                self.removeSpinner()
                 self.navigationController?.popViewController(animated: true)
            }
           

            print(Category+Image)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                self.removeSpinner()
                
            }
            self.digitAlert()
        }
        
        
       
    }

   
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
 
    func digitAlert(){
        SCLAlertView().showInfo("You should type valid name and money", subTitle: "Please type again")
        
    }
    var vSpinner : UIView?
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
