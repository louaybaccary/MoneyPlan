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
    class func  register(username :String,email : String , password : String ){
        let url = "http://127.0.0.1:3000/register/"+username+"/"+email+"/"+password
     Alamofire.request(url)
    
}
    class func setMoney(money : String){
        let url = "http://127.0.0.1:3000/setMoney/"+money
        Alamofire.request(url)
        
    }
}
