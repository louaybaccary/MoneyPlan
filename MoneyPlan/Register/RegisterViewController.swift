//
//  RegisterViewController.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/21/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
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
   
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
                 print("no")
              SCLAlertView().showInfo("Wrong Credentials", subTitle: "Please type again")
            }
            else{
                
                if self.isStringAnInt(string: self.textMoney.text!){
                    if self.isValidEmail(testStr : self.textEmail.text!){
                      API.register(username: self.textUsername.text!, email: self.textEmail.text!, password: self.textPassword.text!, money: String(self.textMoney.text!))
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
                      
                        //    self.show(nextViewController, sender: Any?.self)
                        self.present(nextViewController, animated:true, completion:nil)
                  
                        
                        API.getUser(username: self.textUsername.text!) { (error :Error?, myUser :[User]?) in
                            if let myUser = myUser {
                                self.myUser = myUser
                                self.reloadInputViews()
                                
                                API.create(id: String(myUser[0].id), username: myUser[0].username)
                                
                                
                            }
                        }
                }else {
                    self.emailAlert()
                }
                }else {
                    self.digitAlert()
                }
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
      //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        super.viewDidLoad()
      
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
    
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    func emailAlert(){
        SCLAlertView().showInfo("Wrong email pattern", subTitle: "Please type again")
        
    }
    func digitAlert(){
        SCLAlertView().showInfo("You should type numbers", subTitle: "Please type again")
        
    }
}
