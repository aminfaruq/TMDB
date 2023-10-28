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
        let movieVC = MainTabBarWireframe.initHome()
        let rootMovieVC = UINavigationController(rootViewController: movieVC)
        setupTabItem(
            rootMovieVC,
            title: "Movie",
            unselectedImage: "film",
            selectedImage: "film.fill")
        
        let tvVC = UIViewController()
        let rootTvVC = UINavigationController(rootViewController: tvVC)
        setupTabItem(
            rootTvVC,
            title: "TV",
            unselectedImage: "tv",
            selectedImage: "tv.fill")

        let personVC = UIViewController()
        let rootPersonVC = UINavigationController(rootViewController: personVC)
        setupTabItem(
            rootPersonVC,
            title: "Person",
            unselectedImage: "person",
            selectedImage: "person.fill")
        
        let searchVC = UIViewController()
        let rootExploreVC = UINavigationController(rootViewController: searchVC)
        setupTabItem(
            rootExploreVC,
            title: "Search",
            unselectedImage: "magnifyingglass",
            selectedImage: "magnifyingglass")
        
        self.viewControllers = [rootMovieVC, rootTvVC, rootPersonVC, rootExploreVC]
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

