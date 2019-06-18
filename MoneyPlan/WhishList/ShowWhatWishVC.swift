//
//  ShowWhatWishVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class ShowWhatWishVC: UIViewController ,UITableViewDataSource,UITableViewDelegate  {
      let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    @IBOutlet weak var tableView: UITableView!
    var transactions = [Transaction]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wish")
        
        let contentView = cell?.viewWithTag(0)
        let image = contentView?.viewWithTag(1) as! UIImageView
        let name = cell!.viewWithTag(2) as! UILabel
        let money = cell!.viewWithTag(3) as! UILabel
        image.image = UIImage (named: transactions[indexPath.item].image)
        name.text = transactions[indexPath.item].name
        print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData1()
        //     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wishPhoto")!)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData1), name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
        //   self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wishPhoto")!)
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let moveToTargetAction = UITableViewRowAction(style: .normal, title: "Move to target") { (UITableViewRowAction
            , IndexPath) in
            
          //  print(String(self.transactions[indexPath.item].id))
            //print(API.getID())
            self.tableView.beginUpdates()
            // ** add below line. **
            print(String(self.transactions[indexPath.item].id))
            print(API.getID())
            
            //API.moveToTarget(id: String(self.transactions[indexPath.item].id), userID: API.getID())
            API.moveToTarget(id:String(self.transactions[indexPath.item].id), userID: API.getID())
           self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
            self.fetchData1()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData2"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData3"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData5"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData6"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData7"), object: nil)
        }
        let deleteActionAction = UITableViewRowAction(style: .default, title: "Delete") { (UITableViewRowAction
            , IndexPath) in
            print(String(self.transactions[indexPath.item].id))
            //print(API.getID())
            API.deleteTransaction(id: String(self.transactions[indexPath.item].id))
            print(String(self.transactions[indexPath.item].id))
            print(API.getID())
            self.tableView.beginUpdates()
            // ** add below line. **
            self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
self.fetchData1()
            
        }
        
        return [moveToTargetAction,deleteActionAction]
        
    }
    
    @objc func fetchData1(){
        API.getWhatWhish(username: API.getID()) { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
    }
    
}
