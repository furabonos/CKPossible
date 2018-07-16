//
//  extension.swift
//  CKPossible
//
//  Created by 엄태형 on 2017. 11. 10..
//  Copyright © 2017년 엄태형. All rights reserved.
//

import Foundation

public extension String{
    
    public func validateKor() -> Bool {
        let korRegEx = "^[가-힣]*$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", korRegEx)
        return predicate.evaluate(with: self)
    }

    public func StringCount() -> Int {
        let cc = self.count
        return cc
    }
}
