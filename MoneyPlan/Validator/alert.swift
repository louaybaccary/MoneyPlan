//
//  alert.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import Foundation
import SCLAlertView
class alert{
    class func emailAlert(){
         SCLAlertView().showInfo("Wrong email pattern", subTitle: "Please type again")
        
    }
    class func digitAlert(){
         SCLAlertView().showInfo("You should type numbers", subTitle: "Please type again")
    }
}
