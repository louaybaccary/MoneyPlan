//
//  TargetsViewController.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class TargetsViewController: UIViewController {

    @IBOutlet weak var finished: UIView!
    @IBOutlet weak var current: UIView!
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            current.alpha = 1
            finished.alpha = 0
        } else {
            current.alpha = 0
            finished.alpha = 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        notifications.notifications()
        current.alpha = 1
        finished.alpha = 0
    }
    


}
