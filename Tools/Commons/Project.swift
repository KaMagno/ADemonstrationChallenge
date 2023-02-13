import ProjectDescription

// MARK: - Variables
let name = "Commons"
let bundleId = "com.kaiquemagno.mercadobitcoinchallenge.tools.\(name)"

// MARK: - Targets
let mainTarget = Target(name: name,
                        platform: .iOS,
                        product: .framework,
                        bundleId: bundleId,
                        infoPlist: .default,
                        sources: ["Kit/Sources/**"],
                        resources: ["Kit/Resources/**"])

let testTarget = Target(name: name + "Tests",
                        platform: .iOS,
                        product: .unitTests,
                        bundleId: "\(bundleId).Tests",
                        infoPlist: .default,
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
