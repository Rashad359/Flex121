//
//  Fonts+Ext.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/14/25.
//

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
