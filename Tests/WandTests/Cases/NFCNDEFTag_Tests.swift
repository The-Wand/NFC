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

#if canImport(CoreLocation)
import CoreNFC

import Any_
import WandCoreLocation
import Wand

import XCTest

@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
class NFCNDEFTag_Tests: XCTestCase {

    weak var wand: Wand?

    func test_NFCNDEFTag_read() {
        let e = expectation()
        e.assertForOverFulfill = false

        | { (tag: NFCNDEFTag) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_NFCNDEFTag_write() {
        let e = expectation()

        let m: NFCNDEFMessage = "https://el-machine.com/tool"|
        |.write(message: m) { (done: NFCNDEFTag) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_NFCNDEFTag_lock() {
        let e = expectation()

        |.lock { (done: NFCNDEFTag) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_NFCReaderSession() {
        XCTAssertNotNil(NFCReaderSession.self|)
    }

    func test_closed() throws {
        XCTAssertNil(wand)
    }

//    func test_NFCNDEFMessage_read() {
//        let e = expectation()
//
//        |.one { (stored: NFCNDEFMessage) in
//
//            e.fulfill()
//
//        }
//
//        waitForExpectations(timeout: .default * 4)
//    }
//
//    func test_NFCNDEFMessage_lock() {
//        let e = expectation()
//
//        var lastWrited: Data?
//
//        weak var wand: Wand!
//        wand = |{ (stored: NFCNDEFMessage) in
//
//            guard let record = stored.records.first else {
//                print("Empty tag ‼️")
//                return
//            }
//
//
//            let payload = record.payload
//            guard payload != lastWrited else {
//                print("Same tag 👉👈")
//                return
//            }
//
//            wand | Ask<NFCNDEFTag>.one().lock { done in
//
//                lastWrited = payload
//
//                let content = record.wellKnownTypeURIPayload()?.absoluteString ?? ""
//                print("Locked 🔒 " + content)
//            }
//
//
//        }
//
//        waitForExpectations(timeout: .default * 4)
//    }
//
//    func test_NFCNDEFMessage_write() {
//        let e = expectation()
//
//        var lastWrited: Data?
//
//        weak var wand: Wand!
//        wand = |{ (stored: NFCNDEFMessage) in
//
//            guard let record = stored.records.first else {
//                print("Empty tag ‼️")
//                return
//            }
//
//            let payload = record.payload
//            guard payload != lastWrited else {
//                print("Same tag 👉👈")
//                return
//            }
//
//            let content = "https://el-machine.com/tool"
//            let message: NFCNDEFMessage = content|
//            wand | Ask<NFCNDEFTag>.one().write(message) { done in
//
//                lastWrited = message.records.first?.payload
//
//                print("Writed ✅ " + content)
//
//                e.fulfill()
//
//            }
//
//
//        }
//
//        waitForExpectations(timeout: .default * 4)
//    }
//
//
//}
//
//#endif


}

#endif
