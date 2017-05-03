//
//  ViewController.swift
//  ImagePicker
//
//  Created by olejnjak on 05/03/2017.
//  Copyright (c) 2017 olejnjak. All rights reserved.
//

import UIKit
import ImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private lazy var imagePicker: ImagePicker = ImagePicker(cancelTitle: "Cancel") { [unowned self] image in
        self.imageView.image = image
    }
    
    // MARK: UI actions

    @IBAction func presentButtonTapped(_ sender: UIButton) {
        let cameraSource = ImagePickerSource(source: .camera, title: "Take from camera")
        let photoLibrarySource = ImagePickerSource(source: .photoLibrary, title: "Choose from library")
        
        imagePicker.presentImagePicker(withSources: [cameraSource, photoLibrarySource], mediaTypes: [ImagePickerMediaType.image], from: self)
    }
}

