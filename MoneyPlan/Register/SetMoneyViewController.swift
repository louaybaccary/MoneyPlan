//
//  SetMoneyViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/21/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit

class SetMoneyViewController: UIViewController {
    var username = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        self.dataSource=self
        let childViewController=storyboard?.instantiateViewController(withIdentifier: "some identifier of view") as! ChildViewController
        if let variable = dataToPass {
            print(variable)
            childViewController.variable = dataToPass
    }
           }
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBAction func saveMoneyBtn(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
