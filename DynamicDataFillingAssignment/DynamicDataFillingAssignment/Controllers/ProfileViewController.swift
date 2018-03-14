//
//  ProfileViewController.swift
//  DynamicDataFillingAssignment

import Foundation
import UIKit
import JVFloatLabeledTextField

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var imageViewUserAvatar: UIImageView!
    @IBOutlet weak var textFieldUserName: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldUserEmail: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldDateOfBirth: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldMobileNumber: JVFloatLabeledTextField!
    
    var imagePicker = UIImagePickerController()
    var datePicker: UIDatePicker?
    var toolBar : UIToolbar?
    
    enum TextFieldTags: Int {
        case textFieldUserName = 1, textFieldUserEmail, textFieldDateOfBirth, textFieldMobileNumber
    }
    
    //MARK: View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    @IBAction func buttonAddImageTapped(_ sender: UIButton) {
        initializeAvatarSelectionActionSheet()
    }
    
    @IBAction func buttonSubmitDataTapped(_ sender: UIButton) {
        if (textFieldUserName.text?.trim().isEmpty)! {
            showAlertWithMessage(message: AlertMessageConstants.EMPTY_NAME,
                                 buttonTitle: AlertMessageConstants.OK,
                                 viewController : self)
        } else if !ValidationMethods.isValidEmailAddress(enteredEmail: (textFieldUserEmail.text)!) {
            showAlertWithMessage(message: AlertMessageConstants.INVALID_EMAIL,
                                                      buttonTitle: AlertMessageConstants.OK,
                                                      viewController : self)
        } else if (textFieldDateOfBirth.text?.trim().isEmpty)! {
            showAlertWithMessage(message: AlertMessageConstants.EMPTY_DOB,
                                                      buttonTitle: AlertMessageConstants.OK,
                                                      viewController : self)
        } else if !ValidationMethods.isValidatePhoneNo(value: (textFieldMobileNumber.text)!) {
            showAlertWithMessage(message: AlertMessageConstants.INVALID_MOBILE,
                                                      buttonTitle: AlertMessageConstants.OK,
                                                      viewController : self)
        } else {
            showAlertWithMessage(message: AlertMessageConstants.THANKS_FOR_SUBMITING_INFO,
                                 buttonTitle: AlertMessageConstants.OK,
                                 viewController : self)
            //Call the web service method over here
        }
    }
    
    //MARK: Helper class methods
    /// These methods setsup the UI components
    func setupUI() {
        imageViewUserAvatar.makeImageCircular()
        textFieldUserName.setBottomBorder()
        textFieldUserEmail.setBottomBorder()
        textFieldDateOfBirth.setBottomBorder()
        textFieldMobileNumber.setBottomBorder()
        
        imagePicker.delegate = self
        setTextFieldDelegates()
    }
    
    /// Sets textfield delegates
    func setTextFieldDelegates() {
        textFieldUserName.delegate = self
        textFieldUserEmail.delegate = self
        textFieldDateOfBirth.delegate = self
        textFieldMobileNumber.delegate = self
    }
    
    /// Initializes the action sheet with the options to choose photo from the gallery, camera or remove photo
    func initializeAvatarSelectionActionSheet() {
        let actionSheetAvatarSelection = UIAlertController(title: nil,
                                                           message: ActionSheetConstant.CHOOSE_OPTIONS, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: ActionSheetConstant.GALLERY,
                                         style: .default,
                                         handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallery()
        })
        let cameraAction = UIAlertAction(title: ActionSheetConstant.CAMERA,
                                         style: .default,
                                       handler: {
            (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        let removePhoto = UIAlertAction(title: ActionSheetConstant.REMOVE_PHOTO,
                                        style: .destructive,
                                        handler: {
            (alert: UIAlertAction!) -> Void in
            self.removePhoto()
        })
        let cancelAction = UIAlertAction(title: ActionSheetConstant.CANCEL,
                                         style: .cancel,
                                         handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        actionSheetAvatarSelection.addAction(removePhoto)
        actionSheetAvatarSelection.addAction(galleryAction)
        actionSheetAvatarSelection.addAction(cameraAction)
        actionSheetAvatarSelection.addAction(cancelAction)
        self.present(actionSheetAvatarSelection,
                                   animated: true,
                                   completion: nil)
    }
    
    /// Removes profile photo of user from his profile details.
    func removePhoto() {
        //self.addPhoto = false
        self.imageViewUserAvatar.image = UIImage(named: ImageAssets.USER_DEFAULT_IMAGE)
    }
    
    /// Opens gallery of phone
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    ///  Opens camera of phone
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: ActionSheetConstant.NO_CAMERA,
                                          message: ActionSheetConstant.NO_CAMERA_FOR_DEVICE, preferredStyle: .alert)
            let ok = UIAlertAction(title: ActionSheetConstant.OK,
                                   style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Pick date
    /// Creates datepicker,toolbar and ok and cancel button and allows user to select date
    ///
    /// - Parameter textField: textfield on which date picker view is to be added
    func pickUpDate(textField: UITextField) {
        datePickerSetup(textField: textField)
    }
    
    //MARK: Methods of date picker
    /// Executes the method if ok button date picker is clicked and sets the date selected
    ///
    /// - Parameter sender: button
    @objc func okClicked(sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
        textFieldDateOfBirth.text = dateFormatter.string(from: datePicker!.date)
        textFieldDateOfBirth.resignFirstResponder()
        cancelClicked()
    }
    
    /// Executes if cancel button is clicked
    @objc func cancelClicked() {
        textFieldDateOfBirth.resignFirstResponder()
        datePicker?.removeFromSuperview()
    }
    
    /// Setups date picker and sets it with default date
    ///
    /// - Parameter textField: textfield on which date is to be placed
    func datePickerSetup(textField: UITextField) {
        datePicker = UIDatePicker()
        datePicker!.setValue(UIColor.white, forKeyPath: StringUtilsConstant.TEXT_COLOR)
        datePicker?.backgroundColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        datePicker?.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePicker
        setDefaultDate(textField: textField)
    }
    
    /// select today's date if no date is selected else select the date present on textfield
    ///
    /// - Parameter textField: xtfield on which date is to be placed
    func setDefaultDate(textField: UITextField) {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
        let minimumDate = dateFormatter.date(from: StringUtilsConstant.DEFAULT_DATE)
        datePicker!.maximumDate = todaysDate as Date
        datePicker?.minimumDate = minimumDate
        if textField.text != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = StringUtilsConstant.DATE_FORMAT
            let date = dateFormatter.date(from: textField.text!)
            if let birthDate = date {
                datePicker?.setDate(birthDate, animated: false)
            }
        }
    }
    
    /// Toolbar setup for date picker
    func toolBarSetUp() {
        toolBar = UIToolbar()
        toolBar!.barStyle = .default
        toolBar!.isTranslucent = true
        toolBar!.barTintColor = UIColor.white
        toolBar!.tintColor = UIColor(hexValue: ColorHexValue.NAVIGATION_BAR)
        toolBar!.sizeToFit()
        toolBar!.isUserInteractionEnabled = true
    }
    
    /// Setups ok and cancel button on date picker to choose or cancel date
    ///
    /// - Parameter textField: textfield on which date is to be placed
    func datePickerActionButtonSetup(textField: UITextField) {
        let doneButton = UIBarButtonItem(title: StringUtilsConstant.DONE,
                                         style: .plain,
                                         target: self,
                                         action: #selector(okClicked))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: StringUtilsConstant.CANCEL,
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelClicked))
        toolBar!.setItems([cancelButton, flexSpace, doneButton], animated: false)
    }
    
    /// Setups done button on toolbar to hide keyboard after the user has typed mobile number
    func mobileNumberToolbarSetup() {
        let doneButton = UIBarButtonItem(title: StringUtilsConstant.DONE,
                                         style: .plain,target: self,
                                         action: #selector(buttonDoneTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,               target: nil, action: nil)
        toolBar!.setItems([flexSpace, flexSpace, doneButton], animated: false)
    }
    
    /// Button done tapped user types mobile number
    @objc func buttonDoneTapped() {
        textFieldMobileNumber.resignFirstResponder()
    }
    
    //MARK: Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            imageViewUserAvatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        } else {
            showAlertWithMessage(message: AlertMessageConstants.SOMETHING_WENT_WRONG,
                                                      buttonTitle: AlertMessageConstants.OK,
                                                      viewController : self)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
            case textFieldDateOfBirth:
                pickUpDate(textField: textFieldDateOfBirth)
                toolBarSetUp()
                datePickerActionButtonSetup(textField: textField)
                textField.inputAccessoryView = toolBar
            case textFieldMobileNumber:
                textFieldMobileNumber.becomeFirstResponder()
                toolBarSetUp()
                mobileNumberToolbarSetup()
                textField.inputAccessoryView = toolBar
            default:
                textField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
