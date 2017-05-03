//
//  ImagePickerMediaType.swift
//  Pods
//
//  Created by Jakub Olejník on 04/05/2017.
//
//

import MobileCoreServices

public enum ImagePickerMediaType {
    public static var image: String { return kUTTypeImage as String }
    public static var movie: String { return kUTTypeMovie as String }
}
