//
//  API.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 12/21/18.
//  Copyright © 2018 Louay Baccary. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    class func  register(username :String,email : String , password : String ,money : String)
    {
        let url = "http://127.0.0.1:3000/register/"+username+"/"+email+"/"+password+"/"+money
     Alamofire.request(url)
    
}
    class func login(username : String , password : String, _ completion: @escaping (Bool) -> ()) {
        let url = "http://127.0.0.1:3000/login/"+username+"/"+password
        Alamofire.request(url).responseJSON{response in
            switch response.result
            {
            case .failure:
            
                completion(false)
            case .success:
                if (response.value as? NSDictionary) != nil {
                          let dict = response.value as? NSDictionary
                        let user = dict!["users"] as? NSArray
                   
                        if user!.count > 0 {
                     
                        
                                                completion(true)
                                                }
                                            else {
                            
                                                completion(false)
                            }
                }
            }
        }
}
    class func  Add(name :String,image : String , type : String , category : String , money : String ,userID : String)
    {
        //let url = "http://127.0.0.1:3000/register/"+username+"/"+email+"/"+password+"/"+money
       // Alamofire.request(url)
        
    }
    class func getUser(username : String , completion :@escaping(_ error :Error?,_ userdata : User)-> Void)
        {
    let url = "http://127.0.0.1:3000/getUser/"+username
            Alamofire.request(url).responseJSON {response in
                switch response.result {
                case .failure(let error) :
                    completion(error,User())
                    print(error)
                case .success(let value) :
                    let json = JSON(value)
                    guard let dataArr = json["user"].array else {
                        completion(nil,User())
                        return
                    }
                    //var userdata = [User]()
                    for data in dataArr {
                        guard let data = data.dictionary else {
                            return
                        }
                        let userdata = User()
                        userdata.id = data["id"]?.int ?? 0
                        userdata.email = data["email"]?.string ?? "no data"
                        userdata.password = data["password"]?.string ?? "no data"
                        userdata.username = data["username"]?.string ?? "no data"
                        userdata.money = data["money"]?.int ?? 0
                    
                        completion(nil,userdata)
                    }
                    completion(nil,User())
                }
            }
        }
    class func  AddTarget(username :String,name : String , money : String ,category : String,image : String,type :String)
    {
        let url = "http://127.0.0.1:3000/Insert/"+name+"/"+image+"/"+type+"/"+category+"/"+money+"/"+username
        Alamofire.request(url)
       
    }
        }
    


