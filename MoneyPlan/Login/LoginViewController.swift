//
//  LoginViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/23/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit
import SCLAlertView

class LoginViewController: UIViewController {
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!

    var myUser = [User]()
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //TODO Connect with facebook
    
    @IBAction func LoginBtn(_ sender: Any) {
        //TODO
        //Controle de Saisie
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
                nextViewController.viewDidLoad()
              
                    nextViewController.username = API.getusername()
                nextViewController.id = API.getID()
                
            //    self.show(nextViewController, sender: Any?.self)
             self.present(nextViewController, animated:true, completion:nil)
                API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                    if let myUser = myUser {
                        self.myUser = myUser
                        self.reloadInputViews()

                        API.create(id: String(myUser[0].id), username: myUser[0].username)

                        
                        }
                    }
                    
                }
           else {

               SCLAlertView().showInfo("Wrong Credentials", subTitle: "Please type again")
            }
          
        }

}
}

