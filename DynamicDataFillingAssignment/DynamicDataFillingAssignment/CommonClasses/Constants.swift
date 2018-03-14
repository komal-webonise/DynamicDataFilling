//
//  Constants.swift
//  DynamicDataFillingAssignment
//

import Foundation

typealias ActionSheetConstant = Constants.ActionSheetConstant
typealias ImageAssets = Constants.ImageAssets
typealias StringUtilsConstant = Constants.StringUtilsConstant
typealias ColorHexValue = Constants.ColorHexValue
typealias AlertMessageConstants = Constants.AlertMessageConstants

struct Constants {
    struct ActionSheetConstant {
        static let CHOOSE_OPTIONS = "Choose Option"
        static let GALLERY = "Gallery"
        static let CAMERA = "Camera"
        static let REMOVE_PHOTO = "Remove Photo"
        static let CANCEL = "Cancel"
        static let NO_CAMERA = "Camera Not Found"
        static let NO_CAMERA_FOR_DEVICE = "This device has no Camera"
        static let OK = "OK"
    }
    
    struct ImageAssets {
        static let USER_DEFAULT_IMAGE = "UserDefault"
    }
    
    struct StringUtilsConstant {
        static let TEXT_COLOR = "textColor"
        static let DATE_FORMAT = "dd-MM-yyyy"
        static let DEFAULT_DATE = "01-01-1950"
        static let DONE = "Done"
        static let CANCEL = "Cancel"
    }
    
    struct ColorHexValue {
        static let NAVIGATION_BAR = 0x01334E
    }
    
    struct AlertMessageConstants {
        static let OK = "OK"
        static let INVALID_EMAIL = "Email id is invalid format!"
        static let EMPTY_NAME = "User's name cannot be empty!"
        static let EMPTY_DOB = "User's date of birth cannot be empty!"
        static let INVALID_MOBILE = "Mobile no is invalid format!"
        static let SOMETHING_WENT_WRONG = "Something went wrong"
        static let THANKS_FOR_SUBMITING_INFO = "Thanks for submiting information!"
    }
}
