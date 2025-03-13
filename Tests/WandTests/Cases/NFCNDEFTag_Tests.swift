///
/// Copyright 2020 Alexander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// El Machine 🤖

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
class NFCNDEFTag_Tests: XCTestCase {

    weak var wand: Wand?

//    func test_NFCNDEFTag_read() {
//        let e = expectation()
//
//        wand = |.one { (tag: NFCNDEFTag) in
//            e.fulfill()
//        }
//
//        waitForExpectations(timeout: .default * 2)
//    }
//
//    func test_NFCNDEFTag_write() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        let message: NFCNDEFMessage = "https://el-machine.com/tool"|
//
//        /*wand =*/ |Ask<NFCNDEFTag>.every().write(message) { done in
//            e.fulfill()
//        }
//
//        waitForExpectations(timeout: .default * 2)
//    }
//
//    func test_NFCNDEFTag_lock() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        /*wand =*/ |.every().lock() { (done: NFCNDEFTag) in
//            e.fulfill()
//        }
//
//        waitForExpectations(timeout: .default * 2)
//    }

    func test_NFCReaderSession() {
        XCTAssertNotNil(NFCReaderSession.self|)
    }

    func test_closed() throws {
        XCTAssertNil(wand)
    }

}

#endif
