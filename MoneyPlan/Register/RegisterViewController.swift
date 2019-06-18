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
        self.showSpinner(onView: self.view)
        API.login(username: textUsername.text!, password: textPassword.text!) {
            success in
            if success{
                 print("no")
              SCLAlertView().showInfo("Wrong Credentials,username already exist", subTitle: "Please type again")
            }
            else{
                
                if self.isStringAnInt(string: self.textMoney.text!){
                    if self.isValidEmail(testStr : self.textEmail.text!){
                      API.register(username: self.textUsername.text!, email: self.textEmail.text!, password: self.textPassword.text!, money: String(self.textMoney.text!))
                      
                      
                        //    self.show(nextViewController, sender: Any?.self)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                            self.removeSpinner()
                         /*   let storyBoard : UIStoryboard = UIStoryboard(name: "LoginPage", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginPage") as! MainPageViewController
                            self.present(nextViewController, animated:true, completion:nil)*/
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
                         self.emailAlert()
                }
                }else {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                        self.removeSpinner()
                    }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
                self.removeSpinner()
            }
            
            
        }
     
       // print(textUsername.text!)
    }
    


    override func viewDidLoad() {
      //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        super.viewDidLoad()
        API.deleteAll()
         //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
    
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
