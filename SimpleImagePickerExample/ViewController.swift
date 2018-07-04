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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotoButton.addTarget(self, action: #selector(getPhotoButtonTapped), for: .primaryActionTriggered)
    }
    
    // MARK: UI actions
    
    @objc
    private func getPhotoButtonTapped(sender: UIButton) {
        let sources = [ImagePickerSource(source: .camera, title: "Camera"), ImagePickerSource(source: .photoLibrary, title: "Photo library")]
        imagePicker.sourceView = sender
        imagePicker.sourceRect = sender.bounds
        imagePicker.presentImagePicker(withSources: sources, mediaTypes: [ImagePickerMediaType.image], from: self)
    }
}

