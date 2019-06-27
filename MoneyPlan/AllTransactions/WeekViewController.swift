//
//  WeekViewController.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
     var transactions = [Transaction]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "week")
        
        let contentView = cell?.viewWithTag(0)
        let image = contentView?.viewWithTag(1) as! UIImageView
        let name = cell!.viewWithTag(2) as! UILabel
        let money = cell!.viewWithTag(3) as! UILabel
        switch transactions[indexPath.item].type {
        case "target":
            image.image = UIImage (named: "target")
        case "wish":
            image.image = UIImage (named: "wish")
        case "added":
            image.image = UIImage (named: "add")
        case "minus":
            image.image = UIImage (named: "minus")
        default:
            image.image = UIImage (named: "logo")
        }
        
        name.text = transactions[indexPath.item].name
       
        money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData6()
        notifications.notifications()
    }
    
    @objc func fetchData6(){
        API.getWeek(username:API.getID()) { (error :Error?, transactions : [Transaction]?) in
        if let transactions = transactions {
        self.transactions = transactions
        self.tableView.reloadData()
        }
        }
    }
    
}
