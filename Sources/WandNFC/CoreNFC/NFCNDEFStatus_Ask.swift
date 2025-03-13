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

@available(iOS 13.0, *)
extension NFCNDEFStatus: AskingNil, Wanded {

    @inline(__always)
    public
    static
    func wand<T>(_ wand: Wand, asks ask: Ask<T>) {

        //Save ask
        guard wand.answer(the: ask, check: true) else {
            return
        }

        //Request for a first time

        //Prepare context
        let session: NFCNDEFReaderSession = wand.obtain()

        //Set the cleaner
        wand.setCleaner(for: ask) {
            session.invalidate()
        }

        //Make request
        wand | ask.option { (tag: NFCNDEFTag) in

            session.connect(to: tag) { (error: Error?) in
                
                guard wand.addIf(exist: error) == nil else {
                    session.restartPolling()
                    return
                }
                
                tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in
                    
                    guard wand.addIf(exist: error) == nil else {
                        return
                    }

                    wand.add(capacity)
                    wand.add(status)
                }

            }
            
        }

    }

}

#endif


