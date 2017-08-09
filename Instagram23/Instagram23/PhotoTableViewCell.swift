//
//  PhotoTableViewCell.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import AlamofireImage
import UIKit

protocol PhotoTableViewCellDelegate {
    func photoDoubleClicked(id: String)
    func likeButtonClicked(id: String)
    func showLikes(id: String)
}

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likedImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountButton: UIButton!

    fileprivate let BORDER_WIDTH = CGFloat(1)
    fileprivate let LIKED_DURATION = 0.75
    
    fileprivate var photo: Photo?
    var delegate: PhotoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoViewDoubleClicked(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        photoImageView.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    func setPhoto(_ photo: Photo) {
        self.photo = photo
        
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
        if let url = URL(string: photo.profilePicture) {
            let filter = AspectScaledToFitSizeFilter(size: userPicture.frame.size)
            userPicture.af_setImage(withURL: url, placeholderImage: placeholder, filter: filter)
        } else {
            userPicture.image = placeholder
        }
        
        userName.text = photo.userName

        photoImageView.af_cancelImageRequest()
        if let url = URL(string: photo.lowResolution) {
            let filter = AspectScaledToFitSizeFilter(size: photoImageView.frame.size)
            photoImageView.af_setImage(withURL: url, placeholderImage: placeholder, filter: filter)
        } else {
            photoImageView.image = placeholder
        }

        likedImage.image = likedImage.image?.withRenderingMode(.alwaysTemplate)
        
        likeButton.setImage(likeButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        likeButton.tintColor = photo.userHasLiked ? PRODUCT_COLOR_THEME : UIColor.black
        
        if photo.likesCount == 0 {
            likesCountButton.isHidden = true
        } else {
            let likeKey = photo.likesCount == 1 ? "NUMBER_OF_LIKE" : "NUMBER_OF_LIKES"
            let likeTitle = String.localizedStringWithFormat(NSLocalizedString(likeKey, comment: ""), photo.likesCount)
            likesCountButton.setTitle(likeTitle, for: .normal)
            likesCountButton.isHidden = false
        }
    }
    
    func showLiked() {
        likedImage.isHidden = false
        Timer.scheduledTimer(timeInterval: LIKED_DURATION, target: self, selector: #selector(hideLiked), userInfo: nil, repeats: false)
    }
    
    func hideLiked() {
        likedImage.isHidden = true
    }
    
    func photoViewDoubleClicked(_ sender: AnyObject) {
        guard let id = photo?.id else { return }
        
        delegate?.photoDoubleClicked(id: id)
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        guard let id = photo?.id else { return }
        
        delegate?.likeButtonClicked(id: id)
    }

    @IBAction func likeCountClicked(_ sender: Any) {
        guard let id = photo?.id else { return }
        
        delegate?.showLikes(id: id)
    }
}
