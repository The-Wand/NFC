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
import Foundation.NSDate
import Wand

/// Convert
///
/// let date: Date = interval|
///
@inline(__always)
postfix
public
func |(interval: TimeInterval) -> Date {
    Date(timeIntervalSince1970: interval)
}

/// Convert
///
/// let date: Date = int|
///
@inline(__always)
postfix
public
func |(int: Int) -> Date {
    TimeInterval(int)|
}

/// Convert
///
/// let date: Date? = components|
///
@inline(__always)
postfix
public
func | (components: DateComponents) -> Date? {
    Calendar.current.date(from: components)
}

/// Convert
///
/// let string: String? = date|
///
@inline(__always)
postfix
public
func |(date: Date) -> String {

    let formatted: String?

    if Calendar.current.isDateInToday(date) {
        formatted = date | "HH:mm"
    } else {
        formatted = date | "dd.MM HH:mm"
    }


    return formatted!
}

#endif
