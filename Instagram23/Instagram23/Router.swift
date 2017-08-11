//
//  Router.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  URL generator for REST API calls.
//

import Alamofire
import Foundation
import SwiftyJSON

enum EncodingType {
    case json
    case url
}

enum Router: URLRequestConvertible {
    case logInInstagram()
    case getUser()
    case getRecentMedia()
    case likeMedia(String)
    case unlikeMedia(String)
    case getMediaLikes(String)
    
    func asURLRequest() throws -> URLRequest {
        let result: (method: Alamofire.HTTPMethod, path: String, parameters: [String: AnyObject]?, encoding: EncodingType) = {
            switch self {
            case .logInInstagram():
                return (.get, "/oauth/authorize/", [
                    KEY_CLIENT_ID: CLIENT_ID as AnyObject,
                    KEY_REDIRECT_URI: REDIRECT_URI as AnyObject,
                    KEY_RESPONSE_TYPE: RESPONSE_TYPE_TOKEN as AnyObject
                ], .url)
            case .getUser():
                return (.get, "/v1/users/self/", [
                    KEY_ACCESS_TOKEN: AuthManager.sharedInstance.accessToken as AnyObject
                ], .url)
            case .getRecentMedia():
                return (.get, "/v1/users/self/media/recent/", [
                    KEY_ACCESS_TOKEN: AuthManager.sharedInstance.accessToken as AnyObject
                ], .url)
            case .likeMedia(let id):
                return (.post, "/v1/media/\(id)/likes", [
                    KEY_ACCESS_TOKEN: AuthManager.sharedInstance.accessToken as AnyObject,
                    KEY_SCOPE: SCOPE_PUBLIC_CONTENT as AnyObject
                ], .url)
            case .unlikeMedia(let id):
                return (.delete, "/v1/media/\(id)/likes", [
                    KEY_ACCESS_TOKEN: AuthManager.sharedInstance.accessToken as AnyObject,
                    KEY_SCOPE: SCOPE_PUBLIC_CONTENT as AnyObject
                ], .url)
            case .getMediaLikes(let id):
                return (.get, "/v1/media/\(id)/likes", [
                    KEY_ACCESS_TOKEN: AuthManager.sharedInstance.accessToken as AnyObject,
                    KEY_SCOPE: SCOPE_PUBLIC_CONTENT as AnyObject
                ], .url)
            }
        }()
        
        let URL = Foundation.URL(string: BASE_URL)!
        var urlRequest = URLRequest(url: URL.appendingPathComponent(result.path))
        urlRequest.httpMethod = result.method.rawValue
        
        switch result.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: result.parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: result.parameters)
        }
    }
}
