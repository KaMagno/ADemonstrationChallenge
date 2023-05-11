import ProjectDescription

let allTestsTargets = Scheme(name: "AllTests",
                             shared: true,
                             hidden: false,
                             testAction: .targets([
                                TestableTarget(target: .project(path: "./Features/Exchanges",
                                                                target: "ExchangesTests")),
                                TestableTarget(target: .project(path: "./Tools/Network",
                                                                target: "NetworkTests"))
                             ])
)

let workspace = Workspace(name: "AChallange",
                          projects: [
                            "App",
                            "Features/Exchanges",
                            "Tools/Network",
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
