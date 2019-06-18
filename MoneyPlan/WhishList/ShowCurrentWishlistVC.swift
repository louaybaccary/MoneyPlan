//
//  ShowCurrentWishlistVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class ShowCurrentWishlistVC:  UIViewController ,UITableViewDataSource,UITableViewDelegate {
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
        fetchData()
      //     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wishPhoto")!)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: "fetchData"), object: nil)

        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
      
        let deleteActionAction = UITableViewRowAction(style: .default, title: "Delete") { (UITableViewRowAction
            , IndexPath) in
            API.deleteTransaction(id: String(self.transactions[indexPath.item].id))
            self.tableView.beginUpdates()
            // ** add below line. **
            self.transactions.remove(at: IndexPath.row)
            self.tableView.deleteRows(at: [IndexPath], with: .automatic)
            self.tableView.endUpdates()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)

            self.fetchData()
        }
        
        return [deleteActionAction]
        
    }
    
    @objc func fetchData(){
        API.getTransaction(username: API.getID(),type : "wish") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
    }
    

}
