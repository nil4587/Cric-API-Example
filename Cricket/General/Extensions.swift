//
//  Extensions.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: String
// MARK: ================================

extension String {
    var trimmedString: String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    var length: Int { return self.count }
}

// MARK: - ================================
// MARK: UIView
// MARK: ================================

extension UIView {
    
    var width: CGFloat { get { return self.frame.size.width } set { self.frame.size.width = newValue } }
    var height: CGFloat { get { return self.frame.size.height } set { self.frame.size.height = newValue } }
    var size: CGSize { get { return self.frame.size } set { self.frame.size = newValue } }
    
    var origin: CGPoint { get { return self.frame.origin } set { self.frame.origin = newValue } }
    var x: CGFloat { get { return self.frame.origin.x } set { self.frame.origin.x = newValue } }
    var y: CGFloat { get { return self.frame.origin.y } set { self.frame.origin.y = newValue } }
    var centerX: CGFloat { get { return self.center.x } set { self.center.x = newValue } }
    var centerY: CGFloat { get { return self.center.y } set { self.center.y = newValue } }

    var isPortrait: Bool { return width < height }
    var isLandscape: Bool { return width > height }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    func showDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.3)
        self.layer.shadowOpacity = 0.3
    }
}
