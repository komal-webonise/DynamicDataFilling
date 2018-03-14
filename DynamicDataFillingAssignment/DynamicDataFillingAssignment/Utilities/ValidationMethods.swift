//
//  ValidationMethods.swift
//  DynamicDataFillingAssignment
//

import Foundation

class ValidationMethods {
    // Checks whether email id is in valid format or not
    ///
    /// - Parameter value: email id to be tested
    /// - Returns: true if email id is valid, else returns false
    static func isValidEmailAddress(enteredEmail: String) -> Bool {
        guard !enteredEmail.trim().isEmpty else { return false }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail.trim())
    }
    
    /// Checks whether mobile number is in valid format or not
    ///
    /// - Parameter value: mobile number to be tested
    /// - Returns: true if mobile number is valid, else returns false
    static func isValidatePhoneNo(value: String) -> Bool {
        guard !value.trim().isEmpty else { return false }
        let PHONE_REGEX = "^[789]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value.trim())
        return result
    }
}
