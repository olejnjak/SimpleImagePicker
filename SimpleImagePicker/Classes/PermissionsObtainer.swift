//
//  PermissionsObtainer.swift
//  Pods
//
//  Created by Jakub Olejník on 04/05/2017.
//
//

import UIKit
import Photos

internal typealias PermissionHandler = (PermissionsObtainer.Result) -> Void

internal struct ImagePermissionError: Error {
    let sourceType: UIImagePickerController.SourceType
}

internal enum PermissionsObtainer {
    enum Result {
        case obtained(UIImagePickerController.SourceType)
        case error(ImagePermissionError)
    }
    
    static func obtainPermissions(forSourceType sourceType: UIImagePickerController.SourceType, handler: @escaping PermissionHandler) {
        switch sourceType {
        case .photoLibrary, .savedPhotosAlbum:
            return requestPermission(forSourceType: sourceType, handler: handler)
        case .camera:
            return requestPermissionForCamera(handler: handler)
        }
    }
    
    private static func requestPermission(forSourceType sourceType: UIImagePickerController.SourceType, handler: @escaping PermissionHandler) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .notDetermined:
                    handler(.obtained(sourceType))
                case .restricted, .denied:
                    handler(.error(ImagePermissionError(sourceType: sourceType)))
                }
            }
        }
    }
    
    private static func requestPermissionForCamera(handler: @escaping PermissionHandler) {
        let mediaType = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        
        switch status {
        case .authorized:
            handler(.obtained(.camera))
        case .denied, .restricted:
            handler(.error(ImagePermissionError(sourceType: .camera)))
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                DispatchQueue.main.async {
                    if granted {
                        handler(.obtained(.camera))
                    }
                    else {
                        handler(.error(ImagePermissionError(sourceType: .camera)))
                    }
                }
                
            }
        }
    }
}

