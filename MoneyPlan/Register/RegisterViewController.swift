//
//  RegisterViewController.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
class RegisterViewController: UIViewController {

   
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textMoney: UITextField!
    
    var myUser = [User]()

    @IBAction func btnValidate(_ sender: Any) {
        self.showSpinner(onView: self.view)
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
              SCLAlertView().showInfo("Wrong Credentials,username already exist", subTitle: "Please type again")
            }
            else{
                
                if rules.isStringAnInt(string: self.textMoney.text!){
                    if rules.isValidEmail(testStr : self.textEmail.text!){
                      API.register(username: self.textUsername.text!, email: self.textEmail.text!, password: self.textPassword.text!, money: String(self.textMoney.text!))
                      
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                            self.removeSpinner()

                            API.deleteAll()
                             self.navigationController?.popViewController(animated: true)
                        }
                        API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                            if let myUser = myUser {
                                self.myUser = myUser
                                self.reloadInputViews()
                                
                                API.create(id: String(myUser[0].id), username: myUser[0].username)
                                
                                
                            }
                        }
                }else {
                   
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                            self.removeSpinner()
                                                    }
                         alert.emailAlert()
                }
                }else {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                        self.removeSpinner()
                    }
                    alert.digitAlert()
                }
                API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                    if let myUser = myUser {
                        self.myUser = myUser


                        
                    }
                }
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                self.removeSpinner()
            }
            
            
        }
     

    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        API.deleteAll()
    
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
