//
//  ImageUtility.swift
//  DynamicDataFillingAssignment
//

import Foundation
import UIKit

class ImageUtility {
    
    
}

// MARK: - UIImageView extension
extension UIImageView {
    
     /// This function makes the image circular
     func makeImageCircular() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
