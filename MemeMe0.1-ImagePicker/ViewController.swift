//
//  ViewController.swift
//  MemeMe0.1-ImagePicker
//
//  Created by William Lewis on 10/18/19.
//  Copyright © 2019 William Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: Properties
    var activeField: UITextField? //used to set keyboard notifications only if bottom text field chosen
    /*
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3
    ]
    */
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    //MARK: Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var libraryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //sets the delegates, adds default text, and sets the attributes
        configureTextField(topText, text: "TOP")
        configureTextField(bottomText, text: "BOTTOM")
        
        //cant go in viewWillAppear because thats reset everytime a pic is taken with camera
        self.shareButton.isEnabled = false
        self.cancelButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        //disable camera when camera not available like when using simulator
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    //MARK: Actions
    @IBAction func pickAnImage(_ sender: Any) {
        getImage(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        getImage(.camera)
    }
    
    @IBAction func Share(_ sender: Any) {
        let sharedImage = generateMemedImage() // generate the meme
        //define an instance of ActivityView Controller and pass the ActivityViewController a memedImage as an activity item
        let activityController = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
                self.save()
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image = nil
        topText.text = "TOP" // you could also make this "" to make it an empty stiring bottomField.text="BOTTOM" shareButton.isEnabled=false
        bottomText.text = "BOTTOM"
        self.shareButton.isEnabled = false
    }
    
    //MARK: UIIMagePickercontroller Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
       
    //MARK: Text Delegate Methods
    //sets the delegates for text fields, adds default text, and sets the attributes
    func configureTextField(_ textField: UITextField, text: String) {
               textField.text = text
               textField.delegate = self
               textField.defaultTextAttributes = [
                   .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                   .foregroundColor: UIColor.white,
                   .strokeColor: UIColor.black,
                   .strokeWidth: -3
               ]
               textField.textAlignment = .center
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            var newText = textField.text! as NSString
            newText = newText.replacingCharacters(in: range, with: string) as NSString
            return newText.length <= 30
    }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        if textField.text == "TOP" {
            textField.text = ""
        } else if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: Helper Functions
    //sets delegate, enables buttons and presents image
    func getImage(_ source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        self.shareButton.isEnabled = true
        self.cancelButton.isEnabled = true
        present(pickerController, animated: true, completion: nil)
    }
   
    
    //enables cancel and share buttons and presents view
    func prepButtonsPresentImage(_ controllerName: UIImagePickerController) {
        self.shareButton.isEnabled = true
        self.cancelButton.isEnabled = true
        present(controllerName, animated: true, completion: nil)
    }
    //notifies on keyboard appearing
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
     
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //When the keyboardWillShow notification is received, shift the view's frame up
    @objc func keyboardWillShow(_ notification: Notification) {
        if let usedField = self.view.viewWithTag(1) as? UITextField {
            if activeField == usedField {
            view.frame.origin.y -= getKeyboardHeight(notification)
                print(activeField!)
            }
        }
    }
    
    //When the keyboardWillHide notification is received, shift the view's frame down
    @objc func keyboardWillHide(_ notification: Notification) {
        if let usedField = self.view.viewWithTag(1) as? UITextField {
            if activeField == usedField {
            view.frame.origin.y += getKeyboardHeight(notification)
                print(activeField!)
            }
        }
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: Core Functions
    
    //combine by grab an image context and let it render the view hierarchy(image & textfields in this case) into a UIImage object
    func generateMemedImage() -> UIImage {
        //Hide toolbar and navbar
        self.toolBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        self.toolBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        return memedImage
    }
    
    // initializes a Meme model object using Meme struct
    func save() {
        _ = Meme(topText: self.topText.text!, bottomText: self.bottomText.text!, originalImage: self.imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    
}
    

