//
//  ViewController.swift
//  SimpleImagePickerExample
//
//  Created by Jakub Olejník on 04/07/2018.
//

import UIKit
import SnapKit
import SimpleImagePicker

final class ViewController: UIViewController {

    private weak var imageView: UIImageView!
    private weak var getPhotoButton: UIButton!
    private weak var getPhotoEditButton: UIButton!
    
    private lazy var imagePicker: ImagePicker = { [weak self] in
        let permissionAlert = PermissionAlertConfiguration(title: "Need permission", message: "We need more permission", settings: "Go to settings")
        return ImagePicker(cancelTitle: "Cancel", permissionConfig: permissionAlert) { [weak self] image in
            self?.imageView.image = image
        }
    }()
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        self.imageView = imageView
        
        let getPhotoButton = UIButton(type: .system)
        getPhotoButton.setTitle("Get photo", for: .normal)
        view.addSubview(getPhotoButton)
        getPhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-30)
        }
        self.getPhotoButton = getPhotoButton
        
        let getPhotoEditButton = UIButton(type: .system)
        getPhotoEditButton.setTitle("Get photo with edit", for: .normal)
        view.addSubview(getPhotoEditButton)
        getPhotoEditButton.snp.makeConstraints { (make) in
            make.top.equalTo(getPhotoButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-30)
        }
        self.getPhotoEditButton = getPhotoEditButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotoButton.addTarget(self, action: #selector(getPhotoButtonTapped), for: .primaryActionTriggered)
        getPhotoEditButton.addTarget(self, action: #selector(getPhotoEditButtonTapped), for: .primaryActionTriggered)
    }
    
    // MARK: UI actions
    
    @objc
    private func getPhotoButtonTapped(sender: UIButton) {
        openImagePicker(allowsEditing: false, sender: sender)
    }
    
    @objc
    private func getPhotoEditButtonTapped(sender: UIButton) {
        openImagePicker(allowsEditing: true, sender: sender)
    }
    
    // MARK: Private helpers
    
    private func openImagePicker(allowsEditing: Bool, sender: UIButton) {
        let sources = [ImagePickerSource(source: .camera, title: "Camera"), ImagePickerSource(source: .photoLibrary, title: "Photo library")]
        imagePicker.sourceView = sender
        imagePicker.sourceRect = sender.bounds
        imagePicker.allowsEditing = allowsEditing
        imagePicker.presentImagePicker(withSources: sources, mediaTypes: [ImagePickerMediaType.image], from: self)
    }
}

