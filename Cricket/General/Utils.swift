//
//  Utils.swift
//  Cricket
//
//  Created by Nilesh Prajapati on 21/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: System default alert with message & title
// MARK: ================================

/// A function to display an AlertView with appropriate title & message text
func displayAlert(_ title: String, message: String, completion:((_ index: Int) -> Void)?, otherTitles: String? ...) {
    
    if message.trimmedString == "" {
        return
    }
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    if !otherTitles.isEmpty {
        // Create multiple buttons on Alertview as per given the list of titles
        for (i, title) in otherTitles.enumerated() {
            alert.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
                if (completion != nil) {
                    window.resignKey()
                    AppInfo.appDelegate?.window?.makeKeyAndVisible()
                    completion!(i)
                }
            }))
        }
    } else {
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            if (completion != nil) {
                window.resignKey()
                AppInfo.appDelegate?.window?.makeKeyAndVisible()
                completion!(0)
            }
        }))
    }
    
    DispatchQueue.main.async {
        // Placed baseview just to handler orientation situation as per project's need
        window.rootViewController = BaseViewController()
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

func displayAlert(_ title: String, message: String) {
    displayAlert(title, message: message, completion: nil)
}

func displayAlert(_ message: String) {
    displayAlert(AppInfo.title, message: message)
}
