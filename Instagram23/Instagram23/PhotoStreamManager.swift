//
//  PhotoStreamManager.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Foundation

class PhotoStreamManager {
    class var sharedInstance: PhotoStreamManager {
        struct Singleton {
            static let instance = PhotoStreamManager()
        }
        return Singleton.instance
    }
    
    func getRecentMedia(_ callback: @escaping (_ photos: [Photo]?, _ error: NSError?) -> Void) -> Void {
        if IS_MOCKED {
            MockPhotoStream.getRecentMedia(callback)
        } else {
            PhotoStream.getRecentMedia(callback)
        }
    }
    
    func likeMedia(_ id: String, _ callback: @escaping (_ error: NSError?) -> Void) -> Void {
        if IS_MOCKED {
            MockPhotoStream.likeMedia(id, callback)
        } else {
            PhotoStream.likeMedia(id, callback)
        }
    }
    
    func unlikeMedia(_ id: String, _ callback: @escaping (_ error: NSError?) -> Void) -> Void {
        if IS_MOCKED {
            MockPhotoStream.unlikeMedia(id, callback)
        } else {
            PhotoStream.unlikeMedia(id, callback)
        }
    }
    
    func getMediaLikes(_ id: String, _ callback: @escaping (_ users: [User]?, _ error: NSError?) -> Void) -> Void {
        if IS_MOCKED {
            MockPhotoStream.getMediaLikes(id, callback)
        } else {
            PhotoStream.getMediaLikes(id, callback)
        }
    }
}
