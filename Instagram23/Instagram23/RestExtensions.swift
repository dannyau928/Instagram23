//
//  RestExtensions.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  Prints requests/responses on console output
//

import Alamofire
import Foundation

extension Request {
    public func print() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        
        return self
    }
}

extension HTTPURLResponse {
    public func print() {
        #if DEBUG
            debugPrint(self)
        #endif
    }
}

extension DataResponse {
    public func print() {
        #if DEBUG
            debugPrint(self)
        #endif
    }
}
