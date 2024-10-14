//
//  Extension+Screen.swift
//  KidEduGame
//
//  Created by Xristos Mantsos on 14/10/24.
//

import Foundation
import UIKit

// extension to get the screen sizes!

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
