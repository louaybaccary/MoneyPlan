//
//  MainPageViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/24/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit
import SCLAlertView
import CoreData
class MainPageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
 
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moneyLabel: UILabel!
   
    @IBAction func deconnexion(_ sender: Any) {
      /*  let storyBoard : UIStoryboard = UIStoryboard(name: "LoginPage", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
        self.present(nextViewController, animated:true, completion:nil)*/
    }
    var username = API.getusername()
    var id = API.getID()
    var myUser = [User]()
    var transactions = [Transaction]()
    
    let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    override func viewDidLoad() {
        print(API.getusername())
        print(API.getID())
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mainPhoto")!)
        API.getUser(username: username) { (error :Error?, myUser :[User]?) in
            if let myUser = myUser {
                self.myUser = myUser
                self.reloadInputViews()
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
        API.getTransaction(username: id,type : "target") { (error :Error?, transactions : [Transaction]?) in
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
        image.image = UIImage (named: Images[indexPath.item])
        name.text = transactions[indexPath.item].name
        let per = ((transactions[indexPath.item].currentMoney) * 100) /  (transactions[indexPath.item].trMoney)
        currentMoney.setProgress(Float(per), animated: false)
        money.text = String(transactions[indexPath.item].currentMoney)
        return cell!
    }
    
   

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let plusAction = UITableViewRowAction(style: .normal, title: "+") { (UITableViewRowAction
            , IndexPath) in
            let alert = SCLAlertView()
            let txt = alert.addTextField("Enter the amount of money")
            alert.addButton("+") {
               // let guard
                  //TODO : text = int
                 if self.isStringAnInt(string: txt.text!) == true {
                if (  (self.transactions[indexPath.item].trMoney) >= (Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)){
                      SCLAlertView().showSuccess("OK", subTitle: "")
                    API.setMoney(money: "-"+txt.text!, userID: API.getID())
                    API.setCurrentMoney(money: String((Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)), id: String(self.transactions[indexPath.row].id), userID:self.id)
                  //  [Transaction]()
                    self.tableView.reloadData()
                    self.viewDidLoad()
                } else if ((txt.text!) == ""  || (Int(txt.text!) == 0)) {
                          SCLAlertView().showWarning("Warning", subTitle: "You can't add this amount")
                }
                else {
                    self.digitAlert()
                    }
                 }
            }
            alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
        }
        let minusAction = UITableViewRowAction(style: .default, title: "-") { (UITableViewRowAction
            , IndexPath) in
            let alert = SCLAlertView()
            let txt = alert.addTextField("Enter the amount of money")
            //TODO : text = int
            alert.addButton("-") {
               if self.isStringAnInt(string: txt.text!) == true {
                if ( (Int(txt.text!)!)  > self.transactions[indexPath.item].currentMoney){
                      SCLAlertView().showWarning("Warning", subTitle: "You can't")
                } else if ((txt.text!) == ""  || (Int(txt.text!) == 0)) {
                    SCLAlertView().showSuccess("OK", subTitle: "")
                    API.setMoney(money: txt.text!, userID: "1")
                    API.setCurrentMoney(money: String((self.transactions[indexPath.item].currentMoney)-(Int(txt.text!)!)), id: String(self.transactions[indexPath.row].id), userID: self.id)
                 //   [Transaction]()
                    self.tableView.reloadData()
                    self.viewDidLoad()
                }  else {
                    self.digitAlert()
                }
            }
                
            alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
        }
        }
        return [plusAction,minusAction]
        
    }
  
  

   
    
 
    @IBAction func min(_ sender: Any) {
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("-") {
             //Todo txt = int
             if self.isStringAnInt(string: txt.text!) == true {
           SCLAlertView().showSuccess("You did it", subTitle: "added successfully")
            
            API.setMoney(money: "-"+txt.text!, userID: API.getID())
            API.AddTarget(username: self.id, name: name.text!, money: txt.text!, category: "minus", image: "no", type: "minus")
            self.viewDidLoad()
             }
             else {
                self.digitAlert()
            }
            
        }
        alert.showEdit("Enter the amount of money and a name", subTitle: "")
    }

   
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
 
   func digitAlert(){
        SCLAlertView().showInfo("You should type numbers", subTitle: "Please type again")
        
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("+") {
            //Todo txt = int
            if self.isStringAnInt(string: txt.text!) == true {
                SCLAlertView().showSuccess("You did it", subTitle: "added successfully")
                
                API.setMoney(money: txt.text!, userID: API.getID())
                API.AddTarget(username: self.id, name: name.text!, money: txt.text!, category: "added", image: "no", type: "added")
                self.viewDidLoad()
            }
            else {
                self.digitAlert()
            }
            
        }
        alert.showEdit("Enter the amount of money and a name", subTitle: "")
    }
}


