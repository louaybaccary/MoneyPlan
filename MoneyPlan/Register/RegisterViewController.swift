//
//  RegisterViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/21/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

   
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textMoney: UITextField!
    
    var myUser = [User]()

    @IBAction func btnValidate(_ sender: Any) {
   
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
                 print("no")
              
            }
            else{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
                nextViewController.currentUser = self.textUsername.text!
                self.present(nextViewController, animated:true, completion:nil)
                API.register(username: self.textUsername.text!, email: self.textEmail.text!, password: self.textPassword.text!, money: String(self.textMoney.text!))
                API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                    if let myUser = myUser {
                        self.myUser = myUser
                        self.reloadInputViews()
                        //  API.create(id: String(myUser[0].id), money: String(myUser[0].money), username: String(myUser[0].username))
                        print("okok")
                        
                    }
                }
                
            }
            
            
        }
     
       // print(textUsername.text!)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    
    }

}
