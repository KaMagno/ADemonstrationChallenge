import ProjectDescription

let spmDependencies = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
])

let dependencies = Dependencies(
    swiftPackageManager: spmDependencies,
    platforms: [.iOS]
)
