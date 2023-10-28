//
//  MainTabbarWireframe.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import UIKit

public struct MainTabBarWireframe {
    public static func initHome() -> UIViewController {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "Movie") as? MovieViewController else {
            return UIViewController()
        }
        return vc
    }
}

