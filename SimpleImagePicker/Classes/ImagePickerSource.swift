//
//  ImagePickerSource.swift
//  Pods
//
//  Created by Jakub Olejník on 04/05/2017.
//
//

import UIKit

public struct ImagePickerSource {
    public let source: UIImagePickerController.SourceType
    public let title: String
    
    // MARK: Initializers
    
    public init(source: UIImagePickerController.SourceType, title: String) {
        self.source = source
        self.title = title
    }
}
