//
//  TodayViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var transactions = [Transaction]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "today")
        
        let contentView = cell?.viewWithTag(0)
        let image = contentView?.viewWithTag(1) as! UIImageView
        let name = cell!.viewWithTag(2) as! UILabel
//      let money = cell!.viewWithTag(3) as! UILabel
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
        print(transactions[indexPath.item].name)
    //   money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
          self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        API.getToday(username: API.getID()) { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

}
