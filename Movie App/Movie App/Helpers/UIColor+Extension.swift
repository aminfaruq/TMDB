//
//  UIColor+Extension.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import UIKit

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
