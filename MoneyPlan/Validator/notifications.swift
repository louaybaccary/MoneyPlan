//
//  notifications.swift
//  MoneyPlan
//
//  Created by Louay Baccary  on 1/15/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import Foundation
class notifications{
    class func notifications(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData1"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData2"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData3"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData4"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData5"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData6"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchData7"), object: nil)
    }
    
}
