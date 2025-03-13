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

    //Perfom request
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
        Wand[self]
    }

}

#endif
