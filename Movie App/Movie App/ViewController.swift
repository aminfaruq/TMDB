//
//  ViewController.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureTab()
    }
    
    func configureTab() {
        let tabItems: [(viewController: UIViewController, title: String, unselectedImage: String, selectedImage: String)] = [
            (MainTabBarWireframe.initHome(isTvSeries: false), "Movie", "film", "film.fill"),
            (MainTabBarWireframe.initHome(isTvSeries: true), "TV", "tv", "tv.fill"),
            (UIViewController(), "Person", "person", "person.fill"),
            (UIViewController(), "Search", "magnifyingglass", "magnifyingglass")
        ]
        
        viewControllers = tabItems.map { item in
            let rootVC = UINavigationController(rootViewController: item.viewController)
            setupTabItem(rootVC, title: item.title, unselectedImage: item.unselectedImage, selectedImage: item.selectedImage)
            return rootVC
        }
    }
    
    private func setupTabItem(_ base: UINavigationController, title: String, unselectedImage: String, selectedImage: String) {
        base.tabBarItem = UITabBarItem(
            title: title,
            image: nil,
            selectedImage: nil)
        
        base.tabBarItem.image = tabBarImageFrom(UIImage(systemName: unselectedImage)?.withRenderingMode(.alwaysOriginal))
        base.tabBarItem.selectedImage = tabBarImageFrom(UIImage(systemName: selectedImage)?.withRenderingMode(.alwaysOriginal))
    }
}

