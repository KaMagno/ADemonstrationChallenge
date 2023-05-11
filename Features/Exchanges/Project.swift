import ProjectDescription

// MARK: - Variables
let name = "Exchanges"
let bundleId = "com.kaiquemagno.achallenge.features.\(name)"

// MARK: - Targets
let mainTarget = Target(name: name,
                        platform: .iOS,
                        product: .framework,
                        bundleId: bundleId,
                        infoPlist: .default,
                        sources: ["Kit/Sources/**"],
                        resources: ["Kit/Resources/**"],
                        dependencies: [
                            .project(target: "Network", path: "../../Tools/Network"),
                            .project(target: "UI", path: "../../Tools/UI"),
                            .external(name: "SnapKit")
                        ])

let sampleTarget = Target(name: name + "Sample",
                          platform: .iOS,
                          product: .app,
                          bundleId: "\(bundleId).Sample",
                          sources: ["Sample/Sources/**"],
                          resources: ["Sample/Resources/**"],
                          dependencies: [
                            .target(name: name)
                          ])

let testTarget = Target(name: name + "Tests",
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
                        sampleTarget,
                        testTarget
                      ])
