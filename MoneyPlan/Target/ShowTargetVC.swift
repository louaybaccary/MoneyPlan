//
//  ShowTargetVC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/28/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit

class ShowTargetVC: UIViewController , UITableViewDataSource,UITableViewDelegate{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "target")
        
        let contentView = cell?.viewWithTag(1)
        let image = contentView?.viewWithTag(2) as! UIImageView
        let name = cell!.viewWithTag(3) as! UILabel
        let money = cell!.viewWithTag(4) as! UILabel
        image.image = UIImage (named: Images[indexPath.item])
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
 
return [deletAction]

}
    override func viewDidLoad() {
          // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "targetPhoto")!)
        super.viewDidLoad()
        fetchData3()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData3), name: NSNotification.Name(rawValue: "fetchData3"), object: nil)
        
        
        API.getTransaction(username: API.getID(),type : "target") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                print(API.getID())
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
        
    }
    @objc func fetchData3(){
        API.getTransaction(username: API.getID(),type: "target") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
        
    }
}
