//
//  rules.swift
//  MoneyPlan
//
//  Created by Moncef Guettat on 1/19/19.
//  Copyright © 2019 Louay Baccary. All rights reserved.
//

import Foundation
import Validator

class rules{

  //  let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard,error : someValidationErrorType)
    //let rule = ValidationRuleSet<Any>()
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    class func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
   // let digitRule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: alert.digitAlert())
    
  
}
