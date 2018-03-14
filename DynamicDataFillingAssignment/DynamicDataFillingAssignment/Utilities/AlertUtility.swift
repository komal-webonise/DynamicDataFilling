//
//  AlertUtility.swift
//  DynamicDataFillingAssignment
//

import Foundation
import UIKit

let ALERT_TITLE_OK = "Ok"

var alertController : UIAlertController!
var alertDefaultAction : UIAlertAction!

/// Display alert with a message
///
/// - Parameters:
///   - message: The message to be displayed to the user
///   - buttonTitle: The ViewController on which alert is to displayed
///   - viewController: The text on the cancelButton
func showAlertWithMessage(message: String, buttonTitle: String,
                          viewController : UIViewController) {
    alertController = UIAlertController(title: "",
                                        message: message,
                                        preferredStyle: .alert)
    alertDefaultAction = UIAlertAction(title: buttonTitle,
                                       style: .default,
                                       handler: nil)
    alertController.addAction(alertDefaultAction)
    
    viewController.present(alertController, animated: true, completion: nil)
}
