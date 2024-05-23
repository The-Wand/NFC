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

#if canImport(Foundation)
import Foundation.NSNotification
import Wand

/// Ask
///
/// UIApplication.didBecomeActiveNotification | { (n: Notification) in
///
/// }
///
extension Notification: Asking, Wanded {

    @inline(__always)
    public
    static 
    func wand<T>(_ wand: Wand, asks ask: Ask<T>) {

        let name: Notification.Name = wand.get()!
        let key = name.rawValue

        ask.key = key

        //Save ask
        guard wand.answer(the: ask) else {
            return
        }

        //Prepare context
        let center: NotificationCenter = wand.obtain()

        //Start listening
        let token = center.addObserver(forName: name,
                                       object: nil,
                                       queue: nil) { notification in
            wand.add(notification, for: key)
        }

        //Set the cleaner
        wand.setCleaner(for: ask) {
            center.removeObserver(token)

            log("|🌜 Cleaned '\(ask.key)'")
        }

    }

}

@discardableResult
@inline(__always)
public
func | (name: Notification.Name, handler: @escaping (Notification)->() ) -> Wand {
    Wand(for: name) | .every(handler: handler)
}

@discardableResult
@inline(__always)
public
func | (name: Notification.Name, ask: Ask<Notification>) -> Wand {
    Wand(for: name) | ask
}

#endif
