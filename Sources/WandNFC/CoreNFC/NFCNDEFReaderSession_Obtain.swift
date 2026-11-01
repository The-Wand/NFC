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

#if canImport(CoreNFC)
import CoreNFC
import Wand

extension NFCNDEFReaderSession: Obtainable {
    
    @inline(__always)
    public
    static
    func obtain<C>(with scope: C?, by wand: Core?) -> Self {

        let wand = wand ?? Core()

        let delegate = wand + Delegate()

        let source = Self(delegate: delegate,
                          queue: DispatchQueue.global(),
                          invalidateAfterFirstRead: false) //while

        let message: String = wand.get() ?? "Hold to know what it is 🧙🏾‍♂️"
        source.alertMessage = message

        wand + source

        return wand + source
    }

}

extension NFCNDEFReaderSession {

    class Delegate: NSObject, NFCNDEFReaderSessionDelegate, Wanded {

        @inlinable
        func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
            isWanded + true & "NFCNDEFReaderSessionIsReady"
        }

        @inlinable
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            isWanded + false & "NFCNDEFReaderSessionIsReady"
            isWanded + error
        }

        @inlinable
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        }

        @available(iOS 13.0, *)
        @inlinable
        func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {

            guard let entry = tags.first, let wand = isWanded else {
                return
            }

            let address: Int = entry|// Memory.address(for: tag)
            Core.all[address] = Core.Weak(item: wand)
            wand + entry

//            TODO:
//            if tags.count > 1 {
//                isWanded?.put(tags)
//            }

        }

    }

}

#endif
