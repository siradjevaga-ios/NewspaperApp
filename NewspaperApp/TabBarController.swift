//
//  TabBarController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
    }
    
    private func configureViewControllers() {
        let homeController = HomeController()
        let homeNav = UINavigationController(rootViewController: homeController)
        homeNav.tabBarItem = .init(title: "Home",
                                   image: UIImage(systemName: "house"),
                                   tag: 0)
        let popularcontroller = PopularController()
        let popularNav = UINavigationController(rootViewController: popularcontroller)
        popularNav.tabBarItem = .init(title: "Popular", image: UIImage(systemName: "flame"), tag: 1)
        
        let bookmarkController = BookmarkController()
        let bookNav = UINavigationController(rootViewController: bookmarkController)
        bookNav.tabBarItem = .init(title: "Bookmark", image: UIImage(systemName: "bookmark"), tag: 2)
        viewControllers = [homeNav, popularNav, bookNav]
    }
    
    private func configureUI() {
        tabBar.backgroundColor = .white
    }

}
