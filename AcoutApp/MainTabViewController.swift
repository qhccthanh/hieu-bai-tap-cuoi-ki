//
//  MainTabViewController.swift
//  AcoutApp
//
//  Created by James on 9/10/18.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userViewController = UserViewController()
        userViewController.tabBarItem = UITabBarItem(title: "User Manager", image: nil, tag: 0)
        userViewController.title = " User Manager "
        let userNavi = userViewController.embededNavigationController()
        
        
        let mapUser = MapsUserViewController()
        mapUser.tabBarItem = UITabBarItem(title: "Map User Manager", image: nil, tag: 0)
        mapUser.title = " Check Maps "
        let mapNavi = mapUser.embededNavigationController()
        
        self.viewControllers = [ userNavi , mapNavi ]
    }

}
