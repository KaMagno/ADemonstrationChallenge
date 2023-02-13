import ProjectDescription

let workspace = Workspace(name: "MercadoBitcoinChallange",
                          projects: [
                            "App",
                            "Features/Exchanges",
                            "Tools/MBNetwork",
                            "Tools/Commons",
                          ],
                          additionalFiles: [
                            .glob(pattern: "./README.MD")
                          ],
                          generationOptions: .options(renderMarkdownReadme: true)
)
