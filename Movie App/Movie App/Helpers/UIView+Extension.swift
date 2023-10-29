//
//  UIView+Extension.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import UIKit

extension UIView {
    
    /// func to render view into image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    // MARK: - NIB
    static func nibName() -> String {
        let nameSpaceClassName = NSStringFromClass(self)
        let className = nameSpaceClassName.components(separatedBy: ".").last! as String
        return className
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.nibName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return self.nibName()
    }
    
    func setBorder(_ width: CGFloat, color: UIColor?) {
        self.layer.borderWidth = width
        self.layer.borderColor = color?.cgColor
    }
    
    func setCornerRadius(_ corners: CACornerMask = [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func setTopCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.topLeft, .topRight]
    }
    
    func setBottomCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.bottomLeft, .bottomRight]
    }
    
    func removeSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
}

extension UIViewController {
    func spacingView() -> UIView {
        let spacingView = UIView()
        spacingView.backgroundColor = .clear
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return spacingView
    }
}
