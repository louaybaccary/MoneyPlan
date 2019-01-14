//
//  TargetsViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/14/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit

class TargetsViewController: UIViewController {

    @IBOutlet weak var finished: UIView!
    @IBOutlet weak var current: UIView!
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            current.alpha = 0
            finished.alpha = 1
        } else {
            current.alpha = 1
            finished.alpha = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          self.view.backgroundColor = UIColor(patternImage:UIImage (named: "background")! )
        
        // Do any additional setup after loading the view.
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
