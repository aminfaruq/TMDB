//
//  CACornerMask+Extension.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import UIKit

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
