//
//  ShowCompletedTargetVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/14/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class ShowCompletedTargetVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    var transactions = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData2()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData2), name: NSNotification.Name(rawValue: "fetchData2"), object: nil)

     //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "targetPhoto")!)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchData2(){
        API.getCompletedTarget(username: API.getID()) { (error :Error?, transactions : [Transaction]?) in
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
        let image = contentView?.viewWithTag(2) as! UIImageView
        let name = cell!.viewWithTag(3) as! UILabel
        let money = cell!.viewWithTag(4) as! UILabel
        image.image = UIImage (named: transactions[indexPath.item].image)
        name.text = transactions[indexPath.item].name
        print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deletAction = UITableViewRowAction(style: .default, title: "Delete") { (UITableViewRowAction
            , IndexPath) in
            API.deleteTransaction(id: String(self.transactions[indexPath.item].id))
            self.tableView.beginUpdates()
            // ** add below line. **
            self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData2"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData3"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData5"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData6"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData7"), object: nil)
        }
        let repeatction = UITableViewRowAction(style: .normal, title: "Repeat") { (UITableViewRowAction
            , IndexPath) in
            
            API.AddTarget(username: API.getID(), name: self.transactions[indexPath.item].name, money: String(self.transactions[indexPath.item].trMoney), category: self.transactions[indexPath.item].category, image: self.transactions[indexPath.item].image, type: "target")
            API.deleteTransaction(id: String(self.transactions[indexPath.item].id))
            self.tableView.beginUpdates()
            // ** add below line. **
            self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData2"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData3"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData5"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData6"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData7"), object: nil)

        }
       
        return [deletAction,repeatction]
        
    }
    
}
