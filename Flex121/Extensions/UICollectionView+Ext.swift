//
//  UICollectionView+Ext.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/9/25.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        
        guard let cell = bareCell as? T else { fatalError("Error in dequeueing") }
        return cell
    }
}
