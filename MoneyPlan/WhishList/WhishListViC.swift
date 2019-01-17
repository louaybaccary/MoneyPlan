//
//  WhishListViC.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class WhishListViC: UIViewController {

    @IBOutlet weak var wishView: UIView!
    @IBOutlet weak var whatView: UIView!
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            wishView.alpha = 1
            whatView.alpha = 0
        } else if  sender.selectedSegmentIndex == 1{
            wishView.alpha = 0
            whatView.alpha = 1
        }
        else {
            wishView.alpha = 1
            whatView.alpha = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        // Do any additional setup after loading the view.
    }


}
