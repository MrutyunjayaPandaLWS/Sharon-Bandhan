//
//  Tabbar_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 15/03/22.
//

import UIKit

class Tabbar_VC: UITabBarController {
    
    var window: UIWindow?
    var nav : UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            tabBar.isTranslucent = false
//            tabBar.tintColor = .white
            tabBar.selectedImageTintColor = UIColor(red: 212/255, green: 27/255, blue: 32/255, alpha: 1.0)
//            tabBar.selectedItem.
            tabBar.unselectedItemTintColor = .lightGray
//            UITabBar.appearance().backgroundColor = UIColor(red: 212/255, green: 27/255, blue: 32/255, alpha: 1.0)
        } else {
//            tabBar.tintColor = .white
            UITabBar.appearance().selectedImageTintColor = UIColor(red: 212/255, green: 27/255, blue: 32/255, alpha: 1.0)
            UITabBar.appearance().unselectedItemTintColor = .lightGray
//            UITabBar.appearance().barTintColor = UIColor(red: 212/255, green: 27/255, blue: 32/255, alpha: 1.0)
//            UITabBar.appearance().backgroundColor = UIColor(red: 212/255, green: 27/255, blue: 32/255, alpha: 1.0)
        }
    }
    
    func tabbarLabels() {
        
        let MyRedemptionsVC = storyboard!.instantiateViewController(withIdentifier: "CodeStatus_VC")
        let nav1Controller = UINavigationController(rootViewController: MyRedemptionsVC)
        nav1Controller.tabBarItem.title = "Code Status"
        nav1Controller.tabBarItem.image = UIImage(named: "qr-code-4")
        nav1Controller.isNavigationBarHidden = true
        
        let syncStatusVC = storyboard!.instantiateViewController(withIdentifier: "SyncStatus_VC")
        let nav2Controller = UINavigationController(rootViewController: syncStatusVC)
        nav2Controller.tabBarItem.title = "Sync Status"
        nav2Controller.tabBarItem.image = UIImage(named: "hourglass")
        nav2Controller.isNavigationBarHidden = true
        
        viewControllers = [nav1Controller,nav2Controller]
    }

}
