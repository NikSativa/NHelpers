// swift-tools-version:5.9
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
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "2.1.4"))
    ],
    targets: [
        // MARK: NFoundation
        .target(name: "NFoundation",
                dependencies: [
                ],
                path: "Foundation/Source",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "NFoundationTestHelpers",
                dependencies: [
                    "NFoundation",
                    "NSpry"
                ],
                path: "Foundation/TestHelpers",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
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
                path: "ValueEventier/Source",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "NValueEventierTests",
                    dependencies: [
                        "NValueEventier"
                    ],
                    path: "ValueEventier/Tests"),

        // MARK: NOptionalCodable
        .target(name: "NOptionalCodable",
                dependencies: [
                ],
                path: "OptionalCodable/Source",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "NOptionalCodableTestHelpers",
                dependencies: [
                    "NOptionalCodable",
                    "NSpry"
                ],
                path: "OptionalCodable/TestHelpers",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
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
                path: "Storage/Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "NStorageTestHelpers",
                dependencies: [
                    "NStorage",
                    "NSpry",
                    "NValueEventier"
                ],
                path: "Storage/TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
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
                path: "TextOperators/Source",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
//                .target(name: "NTextOperatorsTestHelpers",
//                        dependencies: [
//                            "NSpry"
//                        ],
//                        path: "TextOperators/TestHelpers",
//                        resources: [
//                            .copy("../../PrivacyInfo.xcprivacy")
//                        ]),
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
                path: "UIKit/Source",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "NUIKitTestHelpers",
                dependencies: [
                    "NUIKit",
                    "NSpry"
                ],
                path: "UIKit/TestHelpers",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]),
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
                ],
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]
               ),
        .target(name: "DateTestHelper",
                dependencies: [
                    "DateHelper",
                    "NSpry"
                ],
                path: "DateHelper/TestHelpers",
                resources: [
                    .copy("../../PrivacyInfo.xcprivacy")
                ]
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
