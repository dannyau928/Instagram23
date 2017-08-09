//
//  User.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  User data model.
//

import Foundation
import SwiftyJSON

struct User {
    var json: JSON?
    
    var id = ""
    var userName = ""
    var fullName = ""
    var profilePicture = ""
    var followedBy = 0
    var follows = 0
    
    init(json: JSON? = nil) {
        guard let json = json else {
            return
        }
        
        self.json = json
        
        id = json[KEY_ID].string ?? ""
        userName = json[KEY_USERNAME].string ?? ""
        fullName = json[KEY_FULL_NAME].string ?? ""
        profilePicture = json[KEY_PROFILE_PICTURE].string ?? ""
        followedBy = json[KEY_COUNTS][KEY_FOLLOWED_BY].int ?? 0
        follows = json[KEY_COUNTS][KEY_FOLLOWS].int ?? 0
    }
}
