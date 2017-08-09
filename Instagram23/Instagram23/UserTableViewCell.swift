//
//  UserTableViewCell.swift
//  Instagram23
//
//  Created by Danny Au on 7/27/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import AlamofireImage
import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    fileprivate let BORDER_WIDTH = CGFloat(1)
    
    fileprivate var user: User?
    
    func setUser(_ user: User) {
        self.user = user
        
        let placeholder = UIImage(named: "genderless_avatar_bg")
        // layout user picture before getting width to set corner radius
        userPicture.setNeedsLayout()
        userPicture.layoutIfNeeded()
        
        // set user picture circular image
        userPicture.layer.cornerRadius = userPicture.frame.width / 2
        userPicture.layer.masksToBounds = true
        userPicture.layer.borderColor = UIColor.gray.cgColor
        userPicture.layer.borderWidth = BORDER_WIDTH
        
        userPicture.af_cancelImageRequest()
        if let url = URL(string: user.profilePicture) {
            let filter = AspectScaledToFitSizeFilter(size: userPicture.frame.size)
            userPicture.af_setImage(withURL: url, placeholderImage: placeholder, filter: filter)
        } else {
            userPicture.image = placeholder
        }
        
        userName.text = user.userName
        fullName.text = user.fullName
    }
}
