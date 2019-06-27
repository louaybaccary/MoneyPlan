//
//  LoginViewController.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit
import SCLAlertView

class LoginViewController: UIViewController {
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!

    var myUser = [User]()
    override func viewDidLoad() {
        API.deleteAll()
        super.viewDidLoad()
        

    }

    
    @IBAction func LoginBtn(_ sender: Any) {
            self.showSpinner(onView: self.view)
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
                API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                    if let myUser = myUser {
                        self.myUser = myUser
                        self.reloadInputViews()
                        API.create(id: String(myUser[0].id), username: myUser[0].username)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                            self.removeSpinner()
                            self.performSegue(withIdentifier: "toHome", sender: self)
                        }
                        }
                    }
                }
           else {

               SCLAlertView().showInfo("Wrong Credentials", subTitle: "Please type again")
                self.removeSpinner()
            }
          
        }


}
    
   
    var vSpinner : UIView?
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

