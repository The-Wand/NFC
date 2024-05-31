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

#if canImport(CoreLocation) && !targetEnvironment(simulator)
import CoreNFC

import Any_
import WandCoreNFC
import Wand

import XCTest

/// Not possible with XCTest
///
/// -[NFCHardwareManager areFeaturesSupported:outError:]:358
/// NSCocoaErrorDomain Code=4099
/// "The connection to service named com.apple.nfcd.service.corenfc
/// was invalidated from this process."
///
/// Use in Play.swift
///
//@available(*, unavailable)
class NFCNDEFTag_Tests: XCTestCase {

    weak var wand: Wand?

    func test_NFCNDEFTag_read() {
        let e = expectation()

        |.one { (tag: NFCNDEFTag) in
            e.fulfill()
        }

        waitForExpectations()
    }

//    func test_NFCNDEFTag_write() {
//        let e = expectation()
//
//        let m: NFCNDEFMessage = "https://el-machine.com/tool"|
//        |.write(message: m) { (done: NFCNDEFTag) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }
//
//    func test_NFCNDEFTag_lock() {
//        let e = expectation()
//
//        |.lock { (done: NFCNDEFTag) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }

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
//
//        waitForExpectations(timeout: .default * 4)
//    }
//
//    func test_NFCNDEFMessage_write() {
//        let e = expectation()
//

//            wand | Ask<NFCNDEFTag>.one().write(message) { done in
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
