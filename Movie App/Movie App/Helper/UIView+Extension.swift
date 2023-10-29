//
//  UIView+Extension.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import Combine
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

func tabBarImageFrom(_ value: UIImage?) -> UIImage {
    let tabBarImageView = TabBarImageView(frame: CGRect(x: 0, y: 0, width: 24.0, height: 24.0))
    tabBarImageView.imageView.image = value
    return tabBarImageView.asImage()
}

/// Only for tabbar image (with size = 24*24)
final class TabBarImageView: UIView {
    
    public let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
}

extension CACornerMask {
    static var top: CACornerMask {
        get {
            return [topLeft, topRight]
        }
    }
    
    static var bottom: CACornerMask {
        get {
            return [bottomLeft, bottomRight]
        }
    }
    
    static var topLeft: CACornerMask {
        get {
            return CACornerMask.layerMinXMinYCorner
        }
    }
    
    static var topRight: CACornerMask {
        get {
            return CACornerMask.layerMaxXMinYCorner
        }
    }
    
    static var bottomLeft: CACornerMask {
        get {
            return CACornerMask.layerMinXMaxYCorner
        }
    }
    
    static var bottomRight: CACornerMask {
        get {
            return CACornerMask.layerMaxXMaxYCorner
        }
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: alpha
            )
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static func interpolateColor(from startColor: UIColor, to endColor: UIColor, percentage: CGFloat) -> UIColor {
        let startComponents = startColor.cgColor.components!
        let endComponents = endColor.cgColor.components!
        
        let r = startComponents[0] + percentage * (endComponents[0] - startComponents[0])
        let g = startComponents[1] + percentage * (endComponents[1] - startComponents[1])
        let b = startComponents[2] + percentage * (endComponents[2] - startComponents[2])
        let a = startComponents[3] + percentage * (endComponents[3] - startComponents[3])
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension URL {
    func downloadImagePublisher() -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: self)
            .map(\.data)
            .mapError({ error in
                error as Error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


public struct ImageHelper {
    public static func getImagePublisher(url: String) -> AnyPublisher<UIImage, Error> {
          guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(url)") else {
              return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)).eraseToAnyPublisher()
          }

          return imageURL.downloadImagePublisher()
              .tryMap { data in
                  guard let image = UIImage(data: data) else {
                      throw NSError(domain: "Image Conversion Error", code: 0, userInfo: nil)
                  }
                  return image
              }
              .eraseToAnyPublisher()
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
