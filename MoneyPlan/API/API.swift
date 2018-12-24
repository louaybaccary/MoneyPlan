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
                print(response)
                completion(false)
            case .success:
                if (response.value as? NSDictionary) != nil {
                          let dict = response.value as? NSDictionary
                        let user = dict!["users"] as? NSArray
                        if user!.count > 0 {
                            print(user!.count)
                                                completion(true)
                                                }
                                            else {
                                                 print(user!.count)
                                                completion(false)
                            }
                }
            }
        }
}
}
