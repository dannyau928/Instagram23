//
//  PhotoLikesViewController.swift
//  Instagram23
//
//  Created by Danny Au on 7/27/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import UIKit

class PhotoLikesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    fileprivate let ESTIMATED_ROW_HEIGHT = CGFloat(50)
    fileprivate let USER_CELL_ID = "userCell"
    
    var mediaId: String?
    fileprivate var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.backItem?.title = ""
        
        tableView.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let mediaId = mediaId else { return }
        
        activityIndicator.startAnimating()
        PhotoStream.getMediaLikes(mediaId) { [weak self] (users, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.activityIndicator.stopAnimating()
            
            if let users = users {
                strongSelf.users = users
                strongSelf.tableView.reloadData()
            } else if error != nil {
                let errorMessage = NSLocalizedString("GET_MEDIA_LIKES_FAILURE_MESSAGE", comment: "")
                Utility.showAlert(strongSelf, title: nil, message: errorMessage, actions: [
                    UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { [weak self] (alert: UIAlertAction!) in
                        self?.navigationController?.popViewController(animated: true)
                    })
                ])
            }
        }
    }
}

// MARK: - Table view datasource/delegate

extension PhotoLikesViewController {
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: USER_CELL_ID, for: indexPath)
        if let userCell = cell as? UserTableViewCell {
            if indexPath.row < users.count {
                userCell.setUser(users[indexPath.row])
            }
        }
        
        return cell
    }
}
