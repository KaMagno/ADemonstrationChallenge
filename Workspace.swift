import ProjectDescription

let allTestsTargets = Scheme(name: "AllTests",
                             shared: true,
                             hidden: false,
                             testAction: .targets([
                                TestableTarget(target: .project(path: "./Features/Exchanges",
                                                                target: "ExchangesTests")),
                                TestableTarget(target: .project(path: "./Tools/MBNetwork",
                                                                target: "MBNetworkTests"))
                             ])
)

let workspace = Workspace(name: "MercadoBitcoinChallange",
                          projects: [
                            "App",
                            "Features/Exchanges",
                            "Tools/MBNetwork",
                            "Tools/Commons",
                            "Tools/MBUI",
                          ],
                          schemes: [
                            allTestsTargets
                          ],
                          additionalFiles: [
                            .glob(pattern: "./README.MD")
                          ],
                          generationOptions: .options(renderMarkdownReadme: true)
)
