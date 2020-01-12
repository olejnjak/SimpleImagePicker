// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SimpleImagePicker",
    platforms: [
        .iOS("8.3"),
    ],
    products: [
        .library(name: "SimpleImagePicker", targets: ["SimpleImagePicker"]),
    ],
    targets: [
        .target(name: "SimpleImagePicker", path: "SimpleImagePicker"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
