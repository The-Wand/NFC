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

#if canImport(CoreNFC)
import CoreNFC
import Wand

extension NFCNDEFReaderSession: Obtain {

    @inline(__always)
    public
    static
    func obtain(by wand: Wand?) -> Self {

        let wand = wand ?? Wand()

        let delegate = wand.add(Delegate())

        let source = Self(delegate: delegate,
                          queue: DispatchQueue.global(),
                          invalidateAfterFirstRead: false) //while

        let message: String = wand.get() ?? "Hold to know what it is 🧙🏾‍♂️"
        source.alertMessage = message

        wand.add(source)

        return wand.add(source)
    }

}

extension NFCNDEFReaderSession {

    class Delegate: NSObject, NFCNDEFReaderSessionDelegate, Wanded {

        func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
            isWanded?.add(true as Bool, for: "NFCNDEFReaderSessionIsReady")
        }

        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            isWanded?.add(false as Bool, for: "NFCNDEFReaderSessionIsReady")
            isWanded?.add(error)
        }

        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        }

        @available(iOS 13.0, *)
        func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {

            guard let first = tags.first, let wand = isWanded else {
                return
            }

            let address = Memory.address(for: first)
            Wand.all[address] = Wand.Weak(item: wand)
            wand.add(first)

//            TODO:
//            if tags.count > 1 {
//                isWanded?.put(tags)
//            }

        }

    }

}

#endif
