//
//  ViewController.swift
//  SimpleImagePicker
//
//  Created by olejnjak on 05/03/2017.
//  Copyright (c) 2017 olejnjak. All rights reserved.
//

import UIKit
import SimpleImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private lazy var imagePicker: ImagePicker = ImagePicker(cancelTitle: "Cancel", permissionConfig: PermissionAlertConfiguration(title: "Need more permissions", message: "Give us more permissions to access media", settings: "Settings")) { [unowned self] image in
        self.imageView.image = image
    }
    
    // MARK: UI actions

    @IBAction func presentButtonTapped(_ sender: UIButton) {
        let cameraSource = ImagePickerSource(source: .camera, title: "Take from camera")
        let photoLibrarySource = ImagePickerSource(source: .photoLibrary, title: "Choose from library")
        
        imagePicker.presentImagePicker(withSources: [cameraSource, photoLibrarySource], mediaTypes: [ImagePickerMediaType.image], from: self)
    }
}

