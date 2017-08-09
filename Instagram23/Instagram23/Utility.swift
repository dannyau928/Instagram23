//
//  Utility.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    static var tabBarController: UIViewController?
    
    class func showAlert(_ viewController: UIViewController, title: String?, message: String, actions: [UIAlertAction]) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}
