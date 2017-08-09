//
//  Photos.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//
//  This class is responsible for all the REST API calls relating to the photo stream.
//

import Alamofire
import Foundation
import SwiftyJSON

class PhotoStream {
    class func getRecentMedia(_ callback: @escaping (_ photos: [Photo]?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(Router.getRecentMedia()).print()
            .validate().responseJSON { (response) -> Void in
                response.print()
                
                switch response.result {
                case .success(let data):
                    var photos = [Photo]()
                    if let jsonArray = JSON(data)[KEY_DATA].array {
                        for jsonPhoto in jsonArray {
                            photos.append(Photo(json: jsonPhoto))
                        }
                    }
                    callback(photos, nil)
                case .failure(let error):
                    callback(nil, error as NSError?)
                }
        }
    }
    
    class func likeMedia(_ id: String, _ callback: @escaping (_ error: NSError?) -> Void) -> Void {
        Alamofire.request(Router.likeMedia(id)).print()
            .validate().responseJSON { (response) -> Void in
                response.print()
                
                switch response.result {
                case .success(_):
                    callback(nil)
                case .failure(let error):
                    callback(error as NSError?)
                }
        }
    }
    
    class func unlikeMedia(_ id: String, _ callback: @escaping (_ error: NSError?) -> Void) -> Void {
        Alamofire.request(Router.unlikeMedia(id)).print()
            .validate().responseJSON { (response) -> Void in
                response.print()
                
                switch response.result {
                case .success(_):
                    callback(nil)
                case .failure(let error):
                    callback(error as NSError?)
                }
        }
    }
    
    class func getMediaLikes(_ id: String, _ callback: @escaping (_ users: [User]?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(Router.getMediaLikes(id)).print()
            .validate().responseJSON { (response) -> Void in
                response.print()
                
                switch response.result {
                case .success(let data):
                    var users = [User]()
                    if let jsonArray = JSON(data)[KEY_DATA].array {
                        for jsonUser in jsonArray {
                            users.append(User(json: jsonUser))
                        }
                    }
                    callback(users, nil)
                case .failure(let error):
                    callback(nil, error as NSError?)
                }
        }
    }
}
