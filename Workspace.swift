import ProjectDescription

let allTestsTargets = Scheme(name: "AllTests",
                             shared: true,
                             hidden: false,
                             testAction: .targets([
                                TestableTarget(target: .project(path: "./Features/Exchanges",
                                                                target: "ExchangesTests")),
                                TestableTarget(target: .project(path: "./Tools/ACNetwork",
                                                                target: "ACNetworkTests"))
                             ])
)

let workspace = Workspace(name: "AChallange",
                          projects: [
                            "App",
                            "Features/Exchanges",
                            "Tools/ACNetwork",
                            "Tools/Commons",
                            "Tools/UI",
                          ],
                          schemes: [
                            allTestsTargets
                          ],
                          additionalFiles: [
                            .glob(pattern: "./README.MD")
                          ],
                          generationOptions: .options(renderMarkdownReadme: true)
)
