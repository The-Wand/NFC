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
extension NFCNDEFMessage: Ask.Nil, Wanded {
    
    @inline(__always)
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
        
        let wand = Core.to(scope)
        
        //Save ask
        guard wand + ask else {
            return wand
        }
        
        //Request for a first time
        
        //Prepare context
        let session: NFCNDEFReaderSession = wand.get()
        
        //Set the cleaner
        ask & {
            session.invalidate()
        }
        
        //Make request
        return wand | ask.depend { (tag: NFCNDEFTag) in

            session.connect(to: tag) { (error: Error?) in
                tag.readNDEF { message, error in
                    if
                        let error = error as? NFCReaderError,
                        error.code != .ndefReaderSessionErrorZeroLengthMessage
                    {
                        wand + (error as Error)
                    }
                    wand + (message ?? NFCNDEFMessage(data: Data())!)
                }
            }

        }
        
    }
    
}

#endif
