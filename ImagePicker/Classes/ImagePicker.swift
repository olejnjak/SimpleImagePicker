//
//  ImagePicker.swift
//  Pods
//
//  Created by Jakub Olejník on 03/05/2017.
//
//

import UIKit

public typealias ImagePickerHandler = (UIImage) -> Void

public class ImagePicker {
    
    private let cancelTitle: String
    private let delegateProxy: ImagePickerDelegateProxy
    
    // MARK: Initializers
    
    public init(cancelTitle: String, handler: @escaping ImagePickerHandler) {
        self.delegateProxy = ImagePickerDelegateProxy(handler: handler)
        self.cancelTitle = cancelTitle
    }
    
    // MARK: Public interface
    
    public func presentImagePicker(withSources sources: [ImagePickerSource], mediaTypes: [String], from viewController: UIViewController) {
        precondition(sources.count > 0, "ImagePicker without any sources doesn't make sense")
        
        let availableSources = sources.filter { UIImagePickerController.isSourceTypeAvailable($0.source) }
        
        precondition(availableSources.count > 0, "Given sources are not available on current device")
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imagePickerPresenter: (ImagePickerSource) -> Void = { [unowned self] source in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source.source
            imagePicker.delegate = self.delegateProxy
            imagePicker.mediaTypes = mediaTypes
            
            viewController.present(imagePicker, animated: true, completion: nil)
        }
        
        availableSources.forEach { source in
            let action = alertAction(forSource: source, handler: imagePickerPresenter)
            alert.addAction(action)
        }
        
        alert.addAction(cancelAction())
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Private helpers
    
    private func alertAction(forSource source: ImagePickerSource, handler: @escaping (ImagePickerSource) -> Void) -> UIAlertAction {
        return UIAlertAction(title: source.title, style: .default) { _ in handler(source) }
    }
    
    private func cancelAction() -> UIAlertAction {
        return UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
    }
}
