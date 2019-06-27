//
//  MainPageViewController.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit
import SCLAlertView
import CoreData
class MainPageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
 
  
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moneyLabel: UILabel!
    var username = API.getusername()
    var id = API.getID()
    var myUser = [User]()
    var transactions = [Transaction]()
    let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    override func viewDidLoad() {
        super.viewDidLoad()
        notifications.notifications()
        fetchData4()
        API.getUser(username: API.getusername()) { (error :Error?, myUser :[User]?) in
            if let myUser = myUser {
                self.myUser = myUser
                self.moneyLabel.text = String(myUser[0].money)
                if ( myUser[0].money > 100){
                    self.moneyLabel.textColor = UIColor.green
                }
                else if ( 0 > myUser[0].money ){
                    self.moneyLabel.textColor = UIColor.red
                }
                else {
                    self.moneyLabel.textColor = UIColor.orange
                    
                }
            }
        
        }
    }
    //Geting all the target of the connected user
    @objc func fetchData4(){
        API.getTransaction(username: API.getID(),type : "target") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "target")
        let contentView = cell?.viewWithTag(1)
        let image = contentView?.viewWithTag(5) as! UIImageView
        let name = cell!.viewWithTag(2) as! UILabel
        let currentMoney = cell!.viewWithTag(4) as! UIProgressView
        let money = cell!.viewWithTag(3) as! UILabel
        image.image = UIImage (named: transactions[indexPath.item].image)
        let per = (Float(transactions[indexPath.item].currentMoney)) /  (Float(transactions[indexPath.item].trMoney))
        name.text = transactions[indexPath.item].name
        currentMoney.setProgress(Float(per), animated: true)
        money.text = String(transactions[indexPath.item].currentMoney)
        return cell!
    }
    
   

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let plusAction = UITableViewRowAction(style: .normal, title: "+") { (UITableViewRowAction
            , IndexPath) in
            let appearance = SCLAlertView.SCLAppearance(
                
                showCloseButton: false // hide default button
            )
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("You can't add more than " + String(self.transactions[indexPath.item].trMoney-self.transactions[indexPath.item].currentMoney))
            
            alert.addButton("+") {
                if rules.isStringAnInt(string: txt.text!) == true
                {
                    if (  (self.transactions[indexPath.item].trMoney) >= (Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)   )
                        {
                            SCLAlertView().showSuccess("OK", subTitle: "Added Successfully")
                            API.setMoney(money: "-"+txt.text!, userID: API.getID())
                            API.setCurrentMoney(money: String((Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)),id:String(self.transactions[indexPath.row].id), userID:API.getID())
                            self.tableView.reloadData()
                            self.viewDidLoad()
                        }
                    else if ((txt.text!) == ""  || (Int(txt.text!) == 0)) {
                          SCLAlertView().showWarning("Warning", subTitle: "You should type valid numbers")
                        }
                    else {
                         SCLAlertView().showWarning("Warning", subTitle: "You can't add this amount")
                    }
                    
                 }
                else{
                SCLAlertView().showWarning("Warning", subTitle: "You should type valid numbers")
                }
            }
            alert.addButton("Cancel") {
                alert.hideView()
            }
            alert.showEdit("Add money", subTitle: "Enter the amount of money you want to add to this target, you can't add more than " + String(self.transactions[indexPath.item].trMoney-self.transactions[indexPath.item].currentMoney))
        }
        let minusAction = UITableViewRowAction(style: .destructive, title: "-") { (UITableViewRowAction
            , IndexPath) in
            let appearance = SCLAlertView.SCLAppearance(
                
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("Enter the amount of money you want to increase from this target, you can't increase more than " + String(self.transactions[indexPath.item].trMoney))
            
            alert.addButton("-") {
                if rules.isStringAnInt(string: txt.text!) == true
                {
                    if ( (Int(txt.text!)!)  > self.transactions[indexPath.item].currentMoney)
                    {
                        SCLAlertView().showWarning("Warning", subTitle: "You can't decrease this amount of money")
                    }
                    else if !((txt.text!) == ""  || (Int(txt.text!) == 0))
                    {
                        SCLAlertView().showSuccess("OK", subTitle: "")
                        API.setMoney(money: txt.text!, userID: API.getID())
                        API.setCurrentMoney(money: String((self.transactions[indexPath.item].currentMoney)-(Int(txt.text!)!)), id: String(self.transactions[indexPath.row].id), userID:API.getID())
                        self.tableView.reloadData()
                        self.viewDidLoad()
                    }
                    else {
                        SCLAlertView().showWarning("Warning", subTitle: "You should type valid numbers")
                    }
                }
                else
                {
                     SCLAlertView().showWarning("Warning", subTitle: "You should type valid numbers")
                }
                
            }
            alert.addButton("Cancel") {
                alert.hideView()
            }
            alert.showEdit("Add money", subTitle: "Enter the amount of money you want to decrease from this target, you can't decrease more than " + String(self.transactions[indexPath.item].currentMoney))
        }
        return [plusAction,minusAction]
        
    }
  
  

   
    
 
    @IBAction func min(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
            
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("-") {
             if rules.isStringAnInt(string: txt.text!) == true {
           SCLAlertView().showSuccess("You did it", subTitle: "Decreased successfully")
            API.setMoney(money: "-"+txt.text!, userID: API.getID())
            API.AddTarget(username: API.getID(), name: name.text!, money: txt.text!, category: "minus", image: "no", type: "minus")
            self.viewDidLoad()
               notifications.notifications()
             }
             else {
                self.digitAlert()
            }
            
        }
        alert.addButton("Cancel") {
            alert.hideView()
        }
        alert.showEdit("Enter the amount of money and a name", subTitle: "")
    }

   func digitAlert(){
    let appearance = SCLAlertView.SCLAppearance(
        
        showCloseButton: false // hide default button
    )
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton("Cancel") {
        alert.hideView()
    }

        alert.showInfo("You should type numbers", subTitle: "Please type again")
        
    }
    
    func digitAlert2(){
        let appearance = SCLAlertView.SCLAppearance(
            
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Cancel") {
            alert.hideView()
        }
        alert.showInfo("Error", subTitle: "You can't add this amount of money")
        
    }

    
    @IBAction func plusBtn(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
            
            showCloseButton: false // hide default button
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("+") {
            if rules.isStringAnInt(string: txt.text!) == true {
                SCLAlertView().showSuccess("You did it", subTitle: "Increased successfully")
                
                API.setMoney(money: txt.text!, userID: API.getID())
                API.AddTarget(username: self.id, name: name.text!, money: txt.text!, category: "added", image: "no", type: "added")
                self.viewDidLoad()
               notifications.notifications()
            }
            else {
                self.digitAlert()
            }
            
        }
        alert.addButton("Cancel") {
            alert.hideView()
        }
        alert.showEdit("Enter the amount of money and a name", subTitle: "")
    }
}

