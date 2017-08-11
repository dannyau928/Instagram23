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
        let getUserCallback = { (_ user: User?, _ error: NSError?) in
            if let user = user {
                self.user = user
            }
            callback(user, error)
        }
        
        if IS_MOCKED {
            MockAuth.getUser(getUserCallback)
        } else {
            Auth.getUser(getUserCallback)
        }
    }
    
    func setAccessToken(accessToken: String) {
        self.accessToken = accessToken
        _ = KeychainWrapper.setString(accessToken, forKey: KEY_ACCESS_TOKEN)
    }
    
    func clearAccessToken() {
        self.accessToken = ""
        _ = KeychainWrapper.removeObjectForKey(KEY_ACCESS_TOKEN)
    }
}
