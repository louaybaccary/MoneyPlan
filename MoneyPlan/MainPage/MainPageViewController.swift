//
//  MainPageViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/24/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var currentUser : String?

    
    @IBOutlet weak var tableView: UITableView!
    var userData = User()
    var transactions = [Transaction]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print(transactions.count)
        return transactions.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "target")
        
        let contentView = cell?.viewWithTag(1)
        //let image = contentView?.viewWithTag(2) as! UIImageView
        let name = cell!.viewWithTag(2) as! UILabel
        let currentMoney = cell!.viewWithTag(4) as! UIProgressView
        let money = cell!.viewWithTag(3) as! UILabel
        //let money = cell!.viewWithTag(4) as! UILabel
      //  image.image = UIImage (named: Images[indexPath.item])
        name.text = transactions[indexPath.item].name
        var per = ((transactions[indexPath.item].currentMoney) * (transactions[indexPath.item].trMoney)) / 100
       currentMoney.setProgress(Float(per), animated: false)
        print(transactions[indexPath.item].name)
        money.text = String(transactions[indexPath.item].trMoney)
       // money.text = String(transactions[indexPath.item].trMoney)
        return cell!
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        API.getUser(username: currentUser!) { (error , myUser
            
            ) in
            
            self.userData.id = myUser.id
    
        }
        API.getTransaction(username: "1",type : "target") { (error :Error?, transactions : [Transaction]?) in
            if let transactions = transactions {
                
                self.transactions = transactions
                self.tableView.reloadData()
            }
  
    }
    
}
}
