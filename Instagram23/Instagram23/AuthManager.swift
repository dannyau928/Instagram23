//
//  AuthManager.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Foundation

class AuthManager {
    var accessToken = ""
    var user = User()
    
    class var sharedInstance: AuthManager {
        struct Singleton {
            static let instance = AuthManager()
        }
        return Singleton.instance
    }

    func getUser(_ callback: @escaping (_ user: User?, _ error: NSError?) -> Void) -> Void {
        if IS_MOCKED {
            MockAuth.getUser(callback)
        } else {
            Auth.getUser(callback)
        }
    }
}
