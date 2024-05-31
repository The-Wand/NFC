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

#if canImport(CoreNFC) && !targetEnvironment(simulator)
import CoreNFC

import Any_
import WandCoreNFC
import Wand

import XCTest

@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
class NFCNDEFMessage_Tests: XCTestCase {

    weak 
    var wand: Wand?

    func test_NFCNDEFMessage_read() {
        let e = expectation()

        /*wand =*/ |.one { (message: NFCNDEFMessage) in
            print("🔗 URL: \(message| as URL?)")
            e.fulfill()
        }

        waitForExpectations(timeout: .default * 2)
    }

    func test_closed() throws {
        XCTAssertNil(wand)
    }

}

#endif
