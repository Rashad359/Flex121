//
//  BaseViewController.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 5/13/25.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    enum Fonts {
        case archivo
        
        var fontName: String {
            switch self {
            case .archivo:
                return "Archivo Black"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
