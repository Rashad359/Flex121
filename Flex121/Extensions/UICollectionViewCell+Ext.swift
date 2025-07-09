//
//  UICollectionViewCell+Ext.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    enum Fonts {
        case archivo
        case EuclidSemibold
        
        var fontName: String {
            switch self {
            case .archivo:
                return "Archivo Black"
            case .EuclidSemibold:
                return "EuclidCircularA-SemiBold"
            }
        }
    }
}
