// swift-tools-version:5.2

import PackageDescription


let packageName = "XParser"
let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12)
    ],
    products: [
        .library(name: packageName, targets: [packageName]),
    ],
    targets: [
        .target(name: packageName, linkerSettings: [.unsafeFlags(["-lxml2"])]),
        .testTarget(name: packageName + "Test", dependencies: [.init(stringLiteral: packageName)])
    ],
    swiftLanguageVersions: [.v5]
)
