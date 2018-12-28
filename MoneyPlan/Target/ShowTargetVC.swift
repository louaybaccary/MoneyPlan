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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hey")
        
        API.getTransaction(username: "1",type : "target") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                self.transactions = transactions
                print(transactions[0].name)
                print(transactions.count)
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
        image.image = UIImage (named: Images[indexPath.item])
       name.text = transactions[indexPath.item].name
        //print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
           
            
           
            API.deleteTransaction(id: String(transactions[indexPath.item].id))
            
                tableView.deleteRows(at: [indexPath], with: .fade)
         
        }


}
}
