//
//  PhotoStreamViewController.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    fileprivate let PHOTO_CELL_ID = "photoCell"
    fileprivate let PHOTO_LIKES_VIEW_CONTROLLER_ID = "photoLikesViewController"
    
    var photos = [Photo]()
    fileprivate var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.estimatedRowHeight = view.frame.width // assuming each media row is a square
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        refreshPhotos()
    }
    
    func refreshPhotos() {
        PhotoStream.getRecentMedia { [weak self] (photos, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.refreshControl.endRefreshing()
            strongSelf.activityIndicator.stopAnimating()
            
            if let photos = photos {
                strongSelf.photos = photos
                strongSelf.tableView.reloadData()
                
                if strongSelf.photos.isEmpty {
                    let emptyMessage = NSLocalizedString("RECENT_MEDIA_EMPTY_MESSAGE", comment: "")
                    Utility.showAlert(strongSelf, title: nil, message: emptyMessage, actions: [
                        UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                    ])
                }
            } else if error != nil {
                let errorMessage = NSLocalizedString("GET_RECENT_MEDIA_FAILURE_MESSAGE", comment: "")
                Utility.showAlert(strongSelf, title: nil, message: errorMessage, actions: [
                    UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                ])
            }
        }
    }
    
    fileprivate func reloadRow(index: Int) {
        if index < photos.count {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()
        }
    }
    
    fileprivate func showCellLiked(_ index: Int) {
        if index < photos.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let photoCell = tableView.cellForRow(at: indexPath) as? PhotoTableViewCell {
                photoCell.showLiked()
            }
        }
    }
    
    fileprivate func likePhoto(_ id: String) {
        if let index = photos.index(where: { $0.id == id }) {
            var photo = photos[index]
            if !photo.userHasLiked {
                PhotoStream.likeMedia(photo.id, { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    
                    if error == nil {
                        photo.userHasLiked = true
                        photo.likesCount += 1
                        strongSelf.photos[index] = photo
                        strongSelf.reloadRow(index: index)
                    } else {
                        let errorMessage = NSLocalizedString("LIKE_MEDIA_FAILURE_MESSAGE", comment: "")
                        Utility.showAlert(strongSelf, title: nil, message: errorMessage, actions: [
                            UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                        ])
                    }
                })
            }
            
            showCellLiked(index)
        }
    }
    
    fileprivate func unlikePhoto(_ id: String) {
        if let index = photos.index(where: { $0.id == id }) {
            var photo = photos[index]
            if photo.userHasLiked {
                PhotoStream.unlikeMedia(photo.id, { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    
                    if error == nil {
                        photo.userHasLiked = false
                        photo.likesCount -= 1
                        strongSelf.photos[index] = photo
                        strongSelf.reloadRow(index: index)
                    } else {
                        let errorMessage = NSLocalizedString("UNLIKE_MEDIA_FAILURE_MESSAGE", comment: "")
                        Utility.showAlert(strongSelf, title: nil, message: errorMessage, actions: [
                            UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                        ])
                    }
                })
            }
        }
    }
}

// MARK: - Table view datasource/delegate

extension PhotoStreamViewController {
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PHOTO_CELL_ID, for: indexPath)
        if let photoCell = cell as? PhotoTableViewCell {
            if indexPath.row < photos.count {
                photoCell.delegate = self
                photoCell.setPhoto(photos[indexPath.row])
            }
        }
        
        return cell
    }
}

// MARK: - PhotoTableViewCellDelegate

extension PhotoStreamViewController: PhotoTableViewCellDelegate {
    func photoDoubleClicked(id: String) {
        likePhoto(id)
    }
    
    func likeButtonClicked(id: String)  {
        if let index = photos.index(where: { $0.id == id }) {
            if photos[index].userHasLiked {
                unlikePhoto(id)
            } else {
                likePhoto(id)
            }
        }
    }
    
    func showLikes(id: String)  {
        if let profileLikesVC = storyboard?.instantiateViewController(withIdentifier: PHOTO_LIKES_VIEW_CONTROLLER_ID) as? PhotoLikesViewController {
            profileLikesVC.mediaId = id
            navigationController?.pushViewController(profileLikesVC, animated: true)
        }
    }
}
