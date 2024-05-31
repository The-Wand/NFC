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

/// AskingNil

///
/// | { (tag: NFCNDEFTag) in
///
/// }
///
@inline(__always)
@discardableResult
prefix
public
func | (handler: @escaping (NFCNDEFTag)->() ) -> Wand {
    nil | Ask.every(handler: handler)
}

///
/// |.one { (tag: NFCNDEFTag) in
///
/// }
///
@inline(__always)
@discardableResult
prefix
public
func | (ask: Ask<NFCNDEFTag>) -> Wand {
    nil | ask
}

/// Asking

///
/// any | { (tag: NFCNDEFTag) in
///
/// }
///
@inline(__always)
@discardableResult
public
func |<C> (context: C, handler: @escaping (NFCNDEFTag)->() ) -> Wand {
    .to(context) | Ask.every(handler: handler)
}

/// Ask
///
/// wand | .every { (tag: NFCNDEFTag) in
///
/// }
///
@inline(__always)
@discardableResult
public
func | (wand: Wand, ask: Ask<NFCNDEFTag>) -> Wand {

    //Save ask
    guard wand.answer(the: ask, check: true) else {
        return wand
    }

    //Request for a first time

    //Prepare context
    let session: NFCNDEFReaderSession = wand.obtain()
    session.alertMessage = wand.get() ?? ""

    DispatchQueue.main.async {
        session.begin()
    }

    //Set the cleaner
    wand.setCleaner(for: ask) {
        session.invalidate()
    }

    return wand
}

@available(iOS 13.0, *)
extension NFCNDEFTag {

    var wand:       Wand    {
        isWanded ?? Wand(for: self)
    }

    var isWanded:   Wand?   {
        nil//TODO: Wand[self]
    }

}

extension Ask where T == NFCNDEFTag {

    @available(iOS 13.0, *)
    public func write (_ message: NFCNDEFMessage, done: @escaping (NFCNDEFTag)->() ) -> Self {

        let oldHandler = self.handler

        self.handler = { tag in

            let wand = tag.wand

            let session: NFCNDEFReaderSession = wand.obtain()

            session.connect(to: tag) { (error: Error?) in

                guard wand.addIf(exist: error) == nil else {
                    return
                }

                wand | .Optional.one { (status: NFCNDEFStatus) in

                    switch status {

                        case .readWrite:

                            let message = message

                            let capacity: Int = wand.get()!
                            if message.length > capacity {

                                let e = Wand.Error.nfc("Tag capacity is too small. Minimum size requirement is \(message.length) bytes.")
                                wand.add(e)

                                return
                            }

                            tag.writeNDEF(message) { (error: Error?) in

                                guard wand.addIf(exist: error) == nil else {
                                    return
                                }

                                done(tag)

                            }

                        case .readOnly:
                            let e = Wand.Error.nfc("Tag is not writable")
                            wand.add(e)

                        case .notSupported:
                            let e = Wand.Error.nfc("Tag is not NDEF")
                            wand.add(e)

                        @unknown default:
                            fatalError()

                    }

                }
                
            }

            //Call previous handler
            return oldHandler(tag)
        }

        return self
    }

//    @available(iOS 13.0, *)
//    public func lock (done: @escaping (NFCNDEFTag)->() ) -> Self {
//
//        let oldHandler = self.handler
//
//        self.handler = { tag in
//
//            let Wand = tag.Wand
//
//            let session: NFCNDEFReaderSession = Wand.get()
//
//            session.connect(to: tag) { (error: Error?) in
//
//                guard Wand.putIf(exist: error) == nil else {
//                    return
//                }
//
//                tag.writeLock { error in
//
//                    if let error = error as? NFCReaderError {
//
//                        switch error.code {
//                            case .ndefReaderSessionErrorTagUpdateFailure:
//
//                                let e = Wand.Error.nfc("Already locked tag 🦾\n")
//                                Wand.add(e)
//
//                            default:
//                                Wand.add(error as Error)
//                        }
//
//
//                        return
//                    }
//
//                    done(tag)
//                }
//
//            }
//
//            //Call previous handler
//            return oldHandler(tag)
//        }
//
//        return self
//    }

}

#endif
