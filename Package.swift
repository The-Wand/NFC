// swift-tools-version: 5.6

///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

import PackageDescription

let package = Package(
    name: "Wand_CoreNFC",
    defaultLocalization: "ru",

    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v7),
    ],

    products: [
        .library(name: "Wand_CoreNFC", targets: ["WandCoreNFC"])
    ],

    dependencies: [
        .package(url: "https://github.com/el-machine/Wand.git", from: "1.2.7"),
        .package(url: "https://github.com/el-machine/Any.git", from: "1.0.0")
    ],

    targets: [

        .target(name: "WandCoreNFC", dependencies: ["Wand"] ),
        .testTarget(name: "wandTests", dependencies:
                        [
                            "WandCoreNFC",
                            .product(name: "Any_", package: "Any")
                        ]
                   )

    ]
)
