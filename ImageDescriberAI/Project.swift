import ProjectDescription

let moduleSettings: SettingsDictionary = [
    "CLANG_VERIFY_MODULES": "YES",
    "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
]

let project = Project(
    name: "ImageDescriberAI",
    targets: [
        .target(
            name: "ImageDescriberAI",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.ImageDescriberAI",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["ImageDescriberAI/Sources/**"],
            resources: ["ImageDescriberAI/Resources/**"],
            dependencies: [
                .target(name: "ImageScannerUI"),
                .target(name: "ImageAnalysis"),
                .target(name: "AIDescriptionService"),
                .target(name: "SharedModels"),
                .target(name: "Utilities")
            ],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "ImageScannerUI",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.ImageScannerUI",
            infoPlist: .default,
            sources: ["Modules/ImageScannerUI/Sources/**"],
            resources: [],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "ImageAnalysis",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.ImageAnalysis",
            infoPlist: .default,
            sources: ["Modules/ImageAnalysis/Sources/**"],
            resources: [],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "AIDescriptionService",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.AIDescriptionService",
            infoPlist: .default,
            sources: ["Modules/AIDescriptionService/Sources/**"],
            resources: [],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "SharedModels",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.SharedModels",
            infoPlist: .default,
            sources: ["Modules/SharedModels/Sources/**"],
            resources: [],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "Utilities",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.Utilities",
            infoPlist: .default,
            sources: ["Modules/Utilities/Sources/**"],
            resources: [],
            settings: .settings(base: moduleSettings)
        ),
        .target(
            name: "ImageDescriberAITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.ImageDescriberAITests",
            infoPlist: .default,
            sources: ["ImageDescriberAI/Tests/**"],
            resources: [],
            dependencies: [.target(name: "ImageDescriberAI")]
        ),
    ]
)
