//
//  Photo.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  Photo data model.
//

import Foundation
import SwiftyJSON

struct Photo {
    var json: JSON?
    
    var id = ""
    var userName = ""
    var profilePicture = ""
    var lowResolution = ""
    var standardResolution = ""
    var userHasLiked = false
    var likesCount = 0
    
    init(json: JSON? = nil) {
        guard let json = json else {
            return
        }
        
        self.json = json
        
        id = json[KEY_ID].string ?? ""
        userName = json[KEY_USER][KEY_USERNAME].string ?? ""
        profilePicture = json[KEY_USER][KEY_PROFILE_PICTURE].string ?? ""
        lowResolution = json[KEY_IMAGES][KEY_LOW_RESOLUTION][KEY_URL].string ?? ""
        standardResolution = json[KEY_IMAGES][KEY_STANDARD_RESOLUTION][KEY_URL].string ?? ""
        userHasLiked = json[KEY_USER_HAS_LIKED].bool ?? false
        likesCount = json[KEY_LIKES][KEY_COUNT].int ?? 0
    }
}
