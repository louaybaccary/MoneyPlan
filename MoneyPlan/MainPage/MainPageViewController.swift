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
    var currentUser : String?

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    var myUser = [User]()
    var transactions = [Transaction]()
    
    let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    override func viewDidLoad() {
        super.viewDidLoad()
     //   moneyLabel.text = "plzzzz"
        API.getUser(username: API.getusername()) { (error :Error?, myUser :[User]?) in
            if let myUser = myUser {
                self.myUser = myUser
                self.reloadInputViews()
                print("myuser")
                print(myUser[0].money)
                print("userdata")
                print(myUser[0].money)
                
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
        
        image.image = UIImage (named: Images[indexPath.item])
        name.text = transactions[indexPath.item].name
        var per = ((transactions[indexPath.item].currentMoney) * 100) /  (transactions[indexPath.item].trMoney)
       // currentMoney.setProgress(Float(per), animated: true)
        currentMoney.setProgress(50, animated: true)
        money.text = String(transactions[indexPath.item].currentMoney)
        return cell!
    }
    
   

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let plusAction = UITableViewRowAction(style: .normal, title: "+") { (UITableViewRowAction
            , IndexPath) in
            let alert = SCLAlertView()
            let txt = alert.addTextField("Enter the amount of money")
            alert.addButton("+") {
                if ( (self.transactions[indexPath.item].trMoney) >= (Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)){
                     SCLAlertView().showWarning("Warning", subTitle: "ok")
                    API.setMoney(money: "-"+txt.text!, userID: API.getID())
                    API.setCurrentMoney(money: String((Int(txt.text!)!)+(self.transactions[indexPath.item].currentMoney)), id: String(self.transactions[indexPath.row].id), userID:API.getID())
                    [Transaction]()
                    self.tableView.reloadData()
                    self.viewDidLoad()
                } else if ((txt.text!) == ""  || (Int(txt.text!) == 0) || ((txt.text!) == nil)) {
                          SCLAlertView().showWarning("Warning", subTitle: "You can't add this amount")
                }
                
            }
            alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
        }
        let minusAction = UITableViewRowAction(style: .default, title: "-") { (UITableViewRowAction
            , IndexPath) in
            let alert = SCLAlertView()
            let txt = alert.addTextField("Enter the amount of money")
            alert.addButton("-") {
              
                if ( (Int(txt.text!)!)  > self.transactions[indexPath.item].currentMoney){
                      SCLAlertView().showWarning("Warning", subTitle: "You can't")
                } else if ((txt.text!) == ""  || (Int(txt.text!) == 0) || ((txt.text!) == nil)) {
                    SCLAlertView().showWarning("Warning", subTitle: "ok")
                    API.setMoney(money: txt.text!, userID: "1")
                    API.setCurrentMoney(money: String((self.transactions[indexPath.item].currentMoney)-(Int(txt.text!)!)), id: String(self.transactions[indexPath.row].id), userID: API.getID())
                    [Transaction]()
                    self.tableView.reloadData()
                    self.viewDidLoad()
                }
            }
            alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
        }
        
        return [plusAction,minusAction]
        
    }
  
    @IBAction func addTransactionBtn(_ sender: Any) {
  
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("+") {
      
                SCLAlertView().showWarning("", subTitle: "ok")
            
            API.setMoney(money: (txt.text!), userID: "1")
            API.AddTarget(username: API.getID(), name: name.text!, money: txt.text!, category: "added", image: "no", type: "added")
                self.viewDidLoad()
          
            }
            alert.showEdit("Thank you", subTitle: "")
            }

  
            
    
        
    
    @IBAction func minusTransactionBtn(_ sender: Any) {
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter the amount of money")
        let name = alert.addTextField("Enter a name")
        alert.addButton("-") {
            
            SCLAlertView().showWarning("", subTitle: "ok")
            
            API.setMoney(money: "-"+txt.text!, userID: "1")
            API.AddTarget(username: API.getID(), name: name.text!, money: txt.text!, category: "minus", image: "no", type: "minus")
            self.viewDidLoad()
            
        }
        alert.showEdit("Thank you", subTitle: "")
    }
    }


