//
//  UserAuthViewController.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Alamofire
import UIKit

class UserAuthViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let USER_AUTH_WEB_VC_ID = "userAuthWebViewController"
    fileprivate let TAB_BAR_CONTROLLER = "tabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let accessToken = KeychainWrapper.stringForKey(KEY_ACCESS_TOKEN) {
            getUser(accessToken)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if IS_MOCKED {
            getUser("")
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let request = Alamofire.request(Router.logInInstagram()).print()
        
        if let urlRequest = request.request, let userAuthWebVC = storyboard?.instantiateViewController(withIdentifier: USER_AUTH_WEB_VC_ID) as? UserAuthWebViewController {
            userAuthWebVC.urlRequest = urlRequest
            userAuthWebVC.callback = { (accessToken: String) -> Void in
                _ = KeychainWrapper.setString(accessToken, forKey: KEY_ACCESS_TOKEN)
                self.getUser(accessToken)
            }

            present(UINavigationController(rootViewController: userAuthWebVC), animated: true, completion: nil)
        }
    }

    fileprivate func getUser(_ accessToken: String) {
        activityIndicator.startAnimating()
        AuthManager.sharedInstance.accessToken = accessToken
        AuthManager.sharedInstance.getUser() { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.activityIndicator.stopAnimating()
            
            if user != nil {
                if let tabBarController = strongSelf.storyboard?.instantiateViewController(withIdentifier: strongSelf.TAB_BAR_CONTROLLER) {
                    tabBarController.modalTransitionStyle = .crossDissolve
                    Utility.tabBarController = tabBarController
                    strongSelf.present(tabBarController, animated: true, completion: nil)
                }
            } else {
                _ = KeychainWrapper.removeObjectForKey(KEY_ACCESS_TOKEN)
                let errorMessage = error?.userInfo[KEY_MESSAGE] as? String ??
                    NSLocalizedString("GET_USER_FAILURE_MESSAGE", comment: "")
                Utility.showAlert(strongSelf, title: nil, message: errorMessage, actions: [
                    UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                ])
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
