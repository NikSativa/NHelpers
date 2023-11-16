// swift-tools-version:5.8
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "NHelpers",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(name: "NFoundation", targets: ["NFoundation"]),
        .library(name: "NFoundationTestHelpers", targets: ["NFoundationTestHelpers"]),

        .library(name: "NValueEventier", targets: ["NValueEventier"]),

        .library(name: "NOptionalCodable", targets: ["NOptionalCodable"]),
        .library(name: "NOptionalCodableTestHelpers", targets: ["NOptionalCodableTestHelpers"]),

        .library(name: "NStorage", targets: ["NStorage"]),
        .library(name: "NStorageTestHelpers", targets: ["NStorageTestHelpers"]),

        .library(name: "NTextOperators", targets: ["NTextOperators"]),
        //        .library(name: "NTextOperatorsTestHelpers", targets: ["NTextOperatorsTestHelpers"]),

        .library(name: "NUIKit", targets: ["NUIKit"]),
        .library(name: "NUIKitTestHelpers", targets: ["NUIKitTestHelpers"]),

        .library(name: "DateHelper", targets: ["DateHelper"]),
        .library(name: "DateTestHelper", targets: ["DateTestHelper"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "2.1.2"))
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
                path: "Foundation/TestHelpers"),
        .testTarget(name: "NFoundationTests",
                    dependencies: [
                        "NSpry",
                        "NFoundation",
                        "NFoundationTestHelpers"
                    ],
                    path: "Foundation/Tests"),

        // MARK: NValueEventier
        .target(name: "NValueEventier",
                dependencies: [
                ],
                path: "ValueEventier/Source"),
        .testTarget(name: "NValueEventierTests",
                    dependencies: [
                        "NValueEventier"
                    ],
                    path: "ValueEventier/Tests"),

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
                        "NSpry",
                        "NOptionalCodable",
                        "NOptionalCodableTestHelpers"
                    ],
                    path: "OptionalCodable/Tests"),

        // MARK: NStorage
        .target(name: "NStorage",
                dependencies: [
                    "NFoundation",
                    "NValueEventier"
                ],
                path: "Storage/Source"),
        .target(name: "NStorageTestHelpers",
                dependencies: [
                    "NStorage",
                    "NSpry",
                    "NValueEventier"
                ],
                path: "Storage/TestHelpers"),
        .testTarget(name: "NStorageTests",
                    dependencies: [
                        "NSpry",
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
                            "NSpry",
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
                path: "UIKit/TestHelpers"),
        .testTarget(name: "NUIKitTests",
                    dependencies: [
                        "NSpry",
                        "NUIKit",
                        "NUIKitTestHelpers"
                    ],
                    path: "UIKit/Tests"),

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
