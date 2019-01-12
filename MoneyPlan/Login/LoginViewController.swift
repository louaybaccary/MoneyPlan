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
    
    override func viewDidLoad() {
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
                nextViewController.currentUser = self.textUsername.text!
                self.present(nextViewController, animated:true, completion:nil)
            }
            else{
                SCLAlertView().showWarning("Warning", subTitle: "Wrong username or password")
        }

}
}
}
