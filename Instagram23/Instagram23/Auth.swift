//
//  Auth.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  This class is responsible for all the REST API calls relating to authentication.
//

import Alamofire
import Foundation
import SwiftyJSON

class Auth {
    static var accessToken = ""
    static var user = User()
    
    class func getUser(_ callback: @escaping (_ user: User?, _ error: NSError?) -> Void) -> Void {
        if !accessToken.isEmpty {
            Alamofire.request(Router.getUser()).print()
                .validate().responseJSON { (response) -> Void in
                    response.print()
                    
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        if json[KEY_DATA] != JSON.null {
                            user = User(json: json[KEY_DATA])
                            callback(user, nil)
                        } else {
                            callback(nil, NSError(domain: "Auth.getUser", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without user data"]))
                        }
                    case .failure(let error):
                        callback(nil, error as NSError?)
                    }
            }
        } else {
            callback(nil, NSError(domain: "Auth.getUser", code: 0, userInfo: [KEY_MESSAGE : "invalid access token"]))
        }
    }
}
