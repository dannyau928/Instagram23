//
//  MockAuth.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Foundation
import SwiftyJSON

class MockAuth: Auth {
    override class func getUser(_ callback: @escaping (_ user: User?, _ error: NSError?) -> Void) -> Void {
        guard let path = Bundle.main.path(forResource: "User", ofType: "json") else {
            callback(nil, NSError(domain: "MockAuth.getUser", code: 0, userInfo: [KEY_MESSAGE : "failed to get path"]))
            return
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            callback(nil, NSError(domain: "MockAuth.getUser", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonString"]))
            return
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            callback(nil, NSError(domain: "MockAuth.getUser", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonData"]))
            return
        }
        
        let jsonObj = JSON(data: jsonData)
        let user = User(json: jsonObj)
        AuthManager.sharedInstance.user = user
        callback(user, nil)
    }
}
