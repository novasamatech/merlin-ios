// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MerlinTranscriptApi",
    products: [
        .library(
            name: "MerlinTranscriptApi",
            targets: ["MerlinTranscriptApi"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "merlin-transcript",
            path: "./bindings/xcframework/merlin_transcript.xcframework"
        ),
        .target(
            name: "MerlinTranscriptApi",
            dependencies: ["merlin-transcript"],
            path: "Sources"
        ),
    ]
)
