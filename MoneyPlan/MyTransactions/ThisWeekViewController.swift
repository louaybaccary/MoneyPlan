//
//  ThisWeekViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class ThisWeekViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let Images = ["add","minus","target","wish"]
    var transactions = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()
        API.getWeek(username: "1") { (error :Error?, transactions : [Transaction]?) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "week")
        
        let contentView = cell?.viewWithTag(1)
        let image = contentView?.viewWithTag(2) as! UIImageView
        let name = cell!.viewWithTag(3) as! UILabel
        let money = cell!.viewWithTag(4) as! UILabel
        switch transactions[indexPath.item].type {
        case "target":
            image.image = UIImage (named: "target")
        case "wish":
            image.image = UIImage (named: "wish")
        case "added":
            image.image = UIImage (named: "add")
        case "deleted":
            image.image = UIImage (named: "minus")
        default:
            image.image = UIImage (named: "logo")
        }
        
        name.text = transactions[indexPath.item].name
        print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
}
