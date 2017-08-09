//
//  ThemedTabBarController.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import UIKit

class ThemedTabBarController: UITabBarController {
    //    private let TAB_BAR_HEIGHT = CGFloat(70)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundImage = getTabBarImage()
        tabBar.tintColor = PRODUCT_COLOR_THEME
    }

    fileprivate func getTabBarImage() -> UIImage {
        let tabBarHeight = tabBar.frame.height
        let imageView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1.0, height: tabBarHeight))
        imageView.backgroundColor = UIColor.white
        let colorView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1.0, height: tabBarHeight))
        colorView.backgroundColor = UIColor.white
        imageView.addSubview(colorView)
        
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
