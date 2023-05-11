import ProjectDescription

/*
 +-------------+
 |             |
 |     App     | Contains A Challenge App target and A Challenge unit-test target
 |             |
 +----------+-----------------+----------+
 |               depends on              |
 |                                       |
 +------v------+                   +-----v-----+
 |             |                   |           |
 |  Feature 1  |                   | Feature 2 |   Two independent Features to share code and start modularising your app
 |             |                   |           |
 +-------------+                   +-----------+
 |                                       |
 |                                       |
 +-------------+-------------+-----------+
 |               depends on
 |
 +------v------+
 |             |
 |    Tool 1   |
 |             |
 +-------------+
 */

// MARK: - Variables
let name = "MainApp"
let bundleId = "com.kaiquemagno.achallenge"

// MARK: - Targets
let mainTarget = Target(name: name,
                        platform: .iOS,
                        product: .app,
                        bundleId: bundleId,
                        infoPlist: .extendingDefault(with: [
                            "UILaunchStoryboardName": .string("LaunchScreen.storyboard")
                        ]),
                        sources: ["Sources/**"],
                        resources: ["Resources/**"],
                        dependencies: [
                            .project(target: "Exchanges", path: "../Features/Exchanges"),
                            .project(target: "Commons", path: "../Tools/Commons"),
                            .project(target: "Network", path: "../Tools/Network"),
                            .external(name: "SnapKit")
                        ])

let testTarget = Target(name: "UnitTests",
                        platform: .iOS,
                        product: .unitTests,
                        bundleId: "\(bundleId).Tests",
                        sources: ["Tests/Sources/**"],
                        resources: ["Tests/Resources/**"],
                        dependencies: [
                            .target(name: name)
                        ])

// MARK: - Project
// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: name,
                      organizationName: "Kaique Magno",
                      targets: [
                        mainTarget,
                        testTarget
                      ])
