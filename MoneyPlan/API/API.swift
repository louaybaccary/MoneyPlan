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
import CoreData

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
            //    print(response.value)
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
    class func getUser(username : String , completion :@escaping(_ error :Error?,_ userdata : [User]?)-> Void)
        {
    let url = "http://127.0.0.1:3000/getUser/"+username
            Alamofire.request(url).responseJSON {response in
                switch response.result {
                case .failure(let error) :
                    completion(error,nil)
                   // print(error)
                case .success(let value) :
                    let json = JSON(value)
                  //  print(json)
                    guard let dataArr = json["user"].array else {
                        completion(nil,nil)
                        return
                    }
                   var users = [User]()
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
                    
                       users.append(userdata)
                    }
                 
                     completion(nil,users)
                }
            }
        }
    class func  AddTarget(username :String,name : String , money : String ,category : String,image : String,type :String)
    {
        let url = "http://127.0.0.1:3000/Insert/"+name+"/"+image+"/"+type+"/"+category+"/"+money+"/"+username
        Alamofire.request(url)
       
    }
    class func getTransaction(username : String ,type : String, completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getTransactions/"+username+"/"+type
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
              //  print(error)
            case .success(let value) :
                let json = JSON(value)
              //  print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
                 //   print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
    }
    class func  deleteTransaction(id :String)
    {
        let url = "http://127.0.0.1:3000/Delete/"+id
        Alamofire.request(url)
        
    }
    class func  setCurrentMoney(money :String,id : String , userID : String)
    {
        let url = "http://127.0.0.1:3000/setCurrentMoney/"+money+"/"+id+"/"+userID
        Alamofire.request(url)
        
    }
   
    class func  setMoney(money :String, userID : String)
    {
        let url = "http://127.0.0.1:3000/setMoney/"+money+"/"+userID
        Alamofire.request(url)
        
    }
    ///Updatetype/32/1
    class func  moveToTarget(id :String, userID : String)
    {
        let url = "http://127.0.0.1:3000/Updatetype/"+id+"/"+userID
        Alamofire.request(url)
        
    }
    class func getCurrentTarget(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getCurentTargets/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
              //  print(error)
            case .success(let value) :
                let json = JSON(value)
               // print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
                  //  print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
    }
    class func getCompletedTarget(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getCompletedTargets/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
               // print(error)
            case .success(let value) :
                let json = JSON(value)
             //   print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
                 //   print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
    }
    class func getWhatWhish(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getWhatWish/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
               // print(error)
            case .success(let value) :
                let json = JSON(value)
               // print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
                   // print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
    }
    class func getToday(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getTodayTrans/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
                //print(error)
            case .success(let value) :
                let json = JSON(value)
               // print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
               //     print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transaction.type = data ["type"]?.string ?? "no data"
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
   
        }
    class func getWeek(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getWeekTrans/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
               // print(error)
            case .success(let value) :
                let json = JSON(value)
              //  print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
                 //   print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transaction.type = data ["type"]?.string ?? "no data"
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
        
    }
    class func getMonth(username : String , completion :@escaping(_ error :Error?,_ transaction : [Transaction]?)-> Void){
        let url = "http://127.0.0.1:3000/getMonthTrans/"+username
        Alamofire.request(url).responseJSON {response in
            switch response.result {
            case .failure(let error) :
                completion(error,nil)
              //  print(error)
            case .success(let value) :
                let json = JSON(value)
            //    print(json)
                guard let dataArr = json["transactions"].array else {
                    completion(nil,nil)
                    return
                }
                var transactions = [Transaction]()
                for data in dataArr {
                    guard let data = data.dictionary else {
                        return
                    }
                    let transaction = Transaction()
                    transaction.id = data["id"]?.int ?? 0
                    transaction.name = data["name"]?.string ?? "no data"
               //     print(transaction.name)
                    transaction.image = data["image"]?.string ?? "no data"
                    transaction.category = data["category"]?.string ?? "no data"
                    transaction.trMoney = data["transaction_money"]?.int ?? 0
                    transaction.currentMoney = data["currentMoney"]?.int ?? 0
                    transaction.type = data ["type"]?.string ?? "no data"
                    transactions.append(transaction)
                    
                }
                completion(nil,transactions)
            }
        }
   
        
    }
    class func create(id : String , username : String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "LocalInfo", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(id, forKey: "id")
        user.setValue(username, forKey: "username")
        
    }
  
    
    class func getID()-> String {
        
       // return LoginViewController.id
      let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        //We need to create a context from this container
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalInfo")
        var id = ""
        do {
            let result = try managedContext.fetch(fetchRequest) 
            for data in result as! [NSManagedObject] {
                id = (data.value(forKey: "id") as! String)
            }
            
        } catch {
            
           // print("Failed")
        }
       // print(id)
          return id
        
         }
    class func getusername()-> String {
       
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        //We need to create a context from this container
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalInfo")
        var username = ""
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                username = (data.value(forKey: "username") as! String)
            }
            
        } catch {
            
         //   print("Failed")
        }
       // print(username)
        return username
    }
    
}
