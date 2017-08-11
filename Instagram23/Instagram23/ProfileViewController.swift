//
//  ProfileViewController.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import AlamofireImage
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!

    fileprivate let BORDER_WIDTH = CGFloat(1)
    
    fileprivate var isLayoutInitialized = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureView.layer.masksToBounds = true
        pictureView.layer.borderColor = UIColor.gray.cgColor
        pictureView.layer.borderWidth = BORDER_WIDTH        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = AuthManager.sharedInstance.user
        let placeholder = UIImage(named: "genderless_avatar_bg")
        if let url = URL(string: user.profilePicture) {
            let filter = AspectScaledToFitSizeFilter(size: pictureView.frame.size)
            pictureView.af_setImage(withURL: url, placeholderImage: placeholder, filter: filter)
        } else {
            pictureView.image = placeholder
        }
        nameLabel.text = user.fullName
        followersLabel.text = String(user.followedBy)
        followingLabel.text = String(user.follows)
    }

    fileprivate func initLayout() {
        // layout pictureView before getting width to set corner radius
        pictureView.setNeedsLayout()
        
        // set circular image
        pictureView.layer.cornerRadius = pictureView.frame.width / 2
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !isLayoutInitialized {
            initLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isLayoutInitialized = true
    }

    @IBAction func logOutClicked(_ sender: Any) {
        let cookieJar = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! as [HTTPCookie] {
            if cookie.domain == API_INSTAGRAM_COOKIE_DOMAIN || cookie.domain == INSTAGRAM_COOKIE_DOMAIN {
                cookieJar.deleteCookie(cookie)
            }
        }

        AuthManager.sharedInstance.accessToken = ""
        _ = KeychainWrapper.removeObjectForKey(KEY_ACCESS_TOKEN)

        Utility.tabBarController?.dismiss(animated: true, completion: { 
            Utility.tabBarController = nil
        })
    }
}

