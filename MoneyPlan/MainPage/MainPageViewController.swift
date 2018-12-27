//
//  MainPageViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/24/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    var currentUser : String?

    
    var userData = User()
    override func viewDidLoad() {
   
        super.viewDidLoad()
        API.getUser(username: currentUser!) { (error , myUser
            
            ) in
            
            self.userData.id = myUser.id
    
        }
  
    }
    
}
