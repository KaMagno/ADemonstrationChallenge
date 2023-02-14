import ProjectDescription

let spmDependencies = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
    .remote(url: "https://github.com/airbnb/lottie-spm.git", requirement: .upToNextMajor(from: "4.1.2"))
])

let dependencies = Dependencies(
    swiftPackageManager: spmDependencies,
    platforms: [.iOS]
)
