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
    
    

    @IBAction func btnValidate(_ sender: Any) {
        //TODO
        //Check unique username
        //TODO
        //Controle de saisie
        
       API.register(username: textUsername.text!, email: textEmail.text!, password: textPassword.text!, money: String(textMoney.text!))
       // print(textUsername.text!)
    }
    

    @IBAction func btnBegin(_ sender: Any) {
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    
    }

}
