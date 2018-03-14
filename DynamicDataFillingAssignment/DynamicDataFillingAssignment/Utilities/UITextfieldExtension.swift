//
//  UITextfieldExtension.swift
//  DynamicDataFillingAssignment
//

import Foundation
import UIKit
import JVFloatLabeledTextField

extension UITextField {
    
    /// These functions sets the bottom border for the UITextFields
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
