//
//  String+Util.swift
//  Pods-SecuredCoreML_Example
//
//  Created by user on 6/19/18.
//

import Foundation


extension String {
    
    func _base64Encoded()->String {
        let utf8str = self.data(using: .utf8)
        
        if let base64Encoded = utf8str?.base64EncodedString() {
            
            return base64Encoded
        }
        return self
    }
}
