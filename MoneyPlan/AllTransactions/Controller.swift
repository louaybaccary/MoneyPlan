//
//  Controller.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class Controller: UIViewController {
    
    @IBOutlet weak var month: UIView!
    @IBOutlet weak var week: UIView!
    @IBOutlet weak var today: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            today.alpha = 1
            week.alpha = 0
            month.alpha = 0
        } else if sender.selectedSegmentIndex == 1{
            today.alpha = 0
            week.alpha = 1
            month.alpha = 0
        }
        else  if sender.selectedSegmentIndex == 2{
            today.alpha = 0
            week.alpha = 0
            month.alpha = 1
        }
        else {
            today.alpha = 1
            week.alpha = 0
            month.alpha = 0
            
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        today.alpha = 1
        week.alpha = 0
        month.alpha = 0
        notifications.notifications()
        
    }
    


}
