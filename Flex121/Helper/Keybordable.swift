//
//  Keybordable.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/21/25.
//

import UIKit
import SnapKit

protocol Keybordable: AnyObject {
    var targetConstraint: Constraint? { get set }
    
    func startKeyboardObserve()
}

extension Keybordable where Self: UIViewController {
    
    private func getHeight(userInfo: [AnyHashable: Any]?) -> CGFloat {
        if let keyboardRect = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            return keyboardRect.height
        }
        return .zero
    }
    
    func startKeyboardObserve() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil) {[weak self] notification in
                let height = self?.getHeight(userInfo: notification.userInfo) ?? .zero
                self?.targetConstraint?.update(offset: -height)
                self?.view.layoutIfNeeded()
            }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.targetConstraint?.update(offset: -16)
                self?.view.layoutIfNeeded()
            }
    }
}
