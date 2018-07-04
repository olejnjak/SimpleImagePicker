//
//  ImagePicker.swift
//  Pods
//
//  Created by Jakub Olejník on 03/05/2017.
//
//

import UIKit

public typealias ImagePickerHandler = (UIImage) -> Void
public typealias PermissionAlertConfiguration = (title: String, message: String, settings: String)

public class ImagePicker {
    public var sourceView: UIView?
    public var sourceRect = CGRect.zero
    public var barButtonItem: UIBarButtonItem?
    
    private let cancelTitle: String
    private let permissionConfig: PermissionAlertConfiguration
    private let delegateProxy: ImagePickerDelegateProxy
    
    // MARK: Initializers
    
    public init(cancelTitle: String, permissionConfig: PermissionAlertConfiguration, handler: @escaping ImagePickerHandler) {
        self.delegateProxy = ImagePickerDelegateProxy(handler: handler)
        self.cancelTitle = cancelTitle
        self.permissionConfig = permissionConfig
    }
    
    // MARK: Public interface
    
    public func presentImagePicker(withSources sources: [ImagePickerSource], mediaTypes: [String], from viewController: UIViewController) {
        precondition(sources.count > 0, "ImagePicker without any sources doesn't make sense")
        
        let availableSources = sources.filter { UIImagePickerController.isSourceTypeAvailable($0.source) }
        
        precondition(availableSources.count > 0, "Given sources are not available on current device")
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imagePickerPresenter: PermissionHandler = { [unowned self] permissionResult in
            switch permissionResult {
            case .obtained(let source):
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = source
                imagePicker.delegate = self.delegateProxy
                imagePicker.mediaTypes = mediaTypes
                viewController.present(imagePicker, animated: true, completion: nil)
            case .error:
                viewController.present(self.createPermissionAlert(), animated: true, completion: nil)
            }
            
            
        }
        
        availableSources.forEach { source in
            let action = alertAction(forSource: source, handler: imagePickerPresenter)
            alert.addAction(action)
        }
        
        alert.popoverPresentationController?.sourceRect = sourceRect
        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.barButtonItem = barButtonItem
        alert.addAction(cancelAction())
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Private helpers
    
    private func alertAction(forSource source: ImagePickerSource, handler: @escaping PermissionHandler) -> UIAlertAction {
        return UIAlertAction(title: source.title, style: .default) { _ in
            PermissionsObtainer.obtainPermissions(forSourceType: source.source, handler: handler)
        }
    }
    
    private func cancelAction() -> UIAlertAction {
        return UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
    }
    
    private func createPermissionAlert() -> UIAlertController {
        let alert = UIAlertController(title: permissionConfig.title, message: permissionConfig.message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: permissionConfig.settings, style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.openURL(url)
        }
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction())
        
        if #available(iOS 9.0, *) {
            alert.preferredAction = settingsAction
        }
        
        return alert
    }
}
