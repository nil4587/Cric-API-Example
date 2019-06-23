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
    
    // To set border color directly through storyboard or .XIB
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // To set border width directly through storyboard or .XIB
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // To set corner radius directly through storyboard or .XIB
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

// MARK: - ================================
// MARK: UIImageView
// MARK: ================================

extension UIImageView {

    // A method to load image from either cache or web-server
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            self.transition(toImage: #imageLiteral(resourceName: "cricket_avtar"))
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInteractive).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                self.getData(from: imageURL) { data, response, error in
                    guard let data = data, error == nil else {
                        DispatchQueue.main.async() {
                            self.transition(toImage: #imageLiteral(resourceName: "cricket_avtar"))
                        }
                        return
                    }
                    #if DEBUG
                    print("Download Finished")
                    #endif
                    DispatchQueue.main.async() {
                        let image = UIImage(data: data)
                        self.transition(toImage: image)
                    }
                }
            }
        }
    }
    
    // A method to make view transition at the time of assigning image
    public func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
    
    // A web-service method to fetch data from the server
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
