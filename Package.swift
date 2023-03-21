// swift-tools-version:5.7
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "NHelpers",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "NFoundation", targets: ["NFoundation"]),
        .library(name: "NFoundationTestHelpers", targets: ["NFoundationTestHelpers"]),
        .library(name: "NFoundationExtraTestHelpers", targets: ["NFoundationExtraTestHelpers"]),

        .library(name: "NObservable", targets: ["NObservable"]),

        .library(name: "NOptionalCodable", targets: ["NOptionalCodable"]),
        .library(name: "NOptionalCodableTestHelpers", targets: ["NOptionalCodableTestHelpers"]),

        .library(name: "NStorage", targets: ["NStorage"]),
        .library(name: "NStorageTestHelpers", targets: ["NStorageTestHelpers"]),

        .library(name: "NTextOperators", targets: ["NTextOperators"]),
        //        .library(name: "NTextOperatorsTestHelpers", targets: ["NTextOperatorsTestHelpers"]),

        .library(name: "NUIKit", targets: ["NUIKit"]),
        .library(name: "NUIKitTestHelpers", targets: ["NUIKitTestHelpers"]),
        .library(name: "NUIKitExtraTestHelpers", targets: ["NUIKitExtraTestHelpers"]),

        .library(name: "NXibView", targets: ["NXibView"]),
        .library(name: "NXibViewTestHelpers", targets: ["NXibViewTestHelpers"]),

        .library(name: "DateHelper", targets: ["DateHelper"]),
        .library(name: "DateTestHelper", targets: ["DateTestHelper"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "1.3.2")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "11.2.1"))
    ],
    targets: [
        // MARK: NFoundation
        .target(name: "NFoundation",
                dependencies: [
                ],
                path: "Foundation/Source"),
        .target(name: "NFoundationTestHelpers",
                dependencies: [
                    "NFoundation",
                    "NSpry"
                ],
                path: "Foundation/TestHelpers/Core"),
        .target(name: "NFoundationExtraTestHelpers",
                dependencies: [
                    "NFoundation",
                    "NFoundationTestHelpers",
                    "NSpry",
                    .product(name: "NSpry_Nimble", package: "NSpry"),
                    "Nimble",
                    "Quick"
                ],
                path: "Foundation/TestHelpers/Extra"),
        .testTarget(name: "NFoundationTests",
                    dependencies: [
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry"),
                        "NFoundation",
                        "NFoundationTestHelpers",
                        "NFoundationExtraTestHelpers"
                    ],
                    path: "Foundation/Tests"),

        // MARK: NObservable
        .target(name: "NObservable",
                dependencies: [
                ],
                path: "Observable/Source"),
        .testTarget(name: "NObservableTests",
                    dependencies: [
                        "NObservable"
                    ],
                    path: "Observable/Tests"),

        // MARK: NOptionalCodable
        .target(name: "NOptionalCodable",
                dependencies: [
                ],
                path: "OptionalCodable/Source"),
        .target(name: "NOptionalCodableTestHelpers",
                dependencies: [
                    "NOptionalCodable",
                    "NSpry"
                ],
                path: "OptionalCodable/TestHelpers"),
        .testTarget(name: "NOptionalCodableTests",
                    dependencies: [
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry"),
                        "NOptionalCodable",
                        "NOptionalCodableTestHelpers"
                    ],
                    path: "OptionalCodable/Tests"),

        // MARK: NStorage
        .target(name: "NStorage",
                dependencies: [
                    "NFoundation",
                    "NObservable"
                ],
                path: "Storage/Source"),
        .target(name: "NStorageTestHelpers",
                dependencies: [
                    "NStorage",
                    "NSpry",
                    "NObservable"
                ],
                path: "Storage/TestHelpers"),
        .testTarget(name: "NStorageTests",
                    dependencies: [
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry"),
                        "NStorage",
                        "NStorageTestHelpers"
                    ],
                    path: "Storage/Tests"),

        // MARK: NTextOperators
        .target(name: "NTextOperators",
                dependencies: [
                ],
                path: "TextOperators/Source"),
        //        .target(name: "NTextOperatorsTestHelpers",
        //                dependencies: [
        //                    "NSpry"
        //                ],
        //                path: "TextOperators/TestHelpers"),
            .testTarget(name: "NTextOperatorsTests",
                        dependencies: [
                            "Nimble",
                            "Quick",
                            "NSpry",
                            .product(name: "NSpry_Nimble", package: "NSpry"),
                            "NTextOperators",
                            //                        "NTextOperatorsTestHelpers"
                            "NFoundationTestHelpers"
                        ],
                        path: "TextOperators/Tests"),

        // MARK: NUIKit
        .target(name: "NUIKit",
                dependencies: [
                    "NFoundation"
                ],
                path: "UIKit/Source"),
        .target(name: "NUIKitTestHelpers",
                dependencies: [
                    "NUIKit",
                    "NSpry"
                ],
                path: "UIKit/TestHelpers/Core"),
        .target(name: "NUIKitExtraTestHelpers",
                dependencies: [
                    "NUIKit",
                    "NUIKitTestHelpers",
                    "NSpry",
                    .product(name: "NSpry_Nimble", package: "NSpry"),
                    "Nimble",
                    "Quick",
                    "NFoundationExtraTestHelpers"
                ],
                path: "UIKit/TestHelpers/Extra"),
        .testTarget(name: "NUIKitTests",
                    dependencies: [
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry"),
                        "NUIKit",
                        "NUIKitTestHelpers",
                        "NUIKitExtraTestHelpers",
                        "NFoundationExtraTestHelpers"
                    ],
                    path: "UIKit/Tests"),

        // MARK: NXibView
        .target(name: "NXibView",
                dependencies: [
                ],
                path: "XibView/Source"),
        .target(name: "NXibViewTestHelpers",
                dependencies: [
                    "NXibView",
                    "NSpry"
                ],
                path: "XibView/TestHelpers"),
        .testTarget(name: "NXibViewTests",
                    dependencies: [
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry"),
                        "NXibView",
                        "NXibViewTestHelpers"
                    ],
                    path: "XibView/Tests"),

        // MARK: DateHelper
        .target(name: "DateHelper",
                dependencies: [
                ],
                path: "DateHelper",
                exclude: [
                    "Tests",
                    "TestHelpers"
                ]
               ),
        .target(name: "DateTestHelper",
                dependencies: [
                    "DateHelper",
                    "NSpry"
                ],
                path: "DateHelper/TestHelpers"
               ),
        .testTarget(name: "DateHelperTests",
                    dependencies: [
                        "DateHelper",
                        "DateTestHelper"
                    ],
                    path: "DateHelper/Tests"
                   )
    ]
)
