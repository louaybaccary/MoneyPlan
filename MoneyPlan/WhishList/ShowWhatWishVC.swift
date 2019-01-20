//
//  ShowWhatWishVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class ShowWhatWishVC: UIViewController ,UITableViewDataSource,UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
      let Images = ["airplane","ambulance","analytics","backpack","ball","book","birthday-cake","brainstorm","business-partnership","car","coffee","commission","contract","drama","emergency","food","friends","grandparents","growth","home","hotel","newlyweds","sexual-harassment","taxi","workspace"]
    var transactions = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wishPhoto")!)
        API.getWhatWhish(username: API.getID()) { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
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
        image.image = UIImage (named: Images[indexPath.item])
        name.text = transactions[indexPath.item].name
        print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
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
            
            API.moveToTarget(id: String(self.transactions[indexPath.item].id), userID: API.getID())
            self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
            
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
            
        }
        
        return [moveToTargetAction,deleteActionAction]
        
    }
    

    
}
