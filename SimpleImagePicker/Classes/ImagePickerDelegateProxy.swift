//
//  UIImagePickerControllerDelegate.swift
//  Pods
//
//  Created by Jakub Olejník on 04/05/2017.
//
//

import UIKit

internal class ImagePickerDelegateProxy: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let handler: ImagePickerHandler
    
    // MARK: Initializers
    
    init(handler: @escaping ImagePickerHandler) {
        self.handler = handler
        super.init()
    }
    
    // MARK: UIImagePickerController delegate
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let key = picker.allowsEditing ? convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage) : convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)
        if let image = info[key] as? UIImage {
            handler(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
