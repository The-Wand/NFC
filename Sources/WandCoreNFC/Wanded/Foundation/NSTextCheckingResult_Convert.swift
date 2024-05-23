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
import Foundation.NSTextCheckingResult
import Wand

/// Convert
///
/// let date: Date? = "tomorrow at 8 UTC+4" | .date
///
@inline(__always)
public
func |(piped: String?,
       type: NSTextCheckingResult.CheckingType) -> Date? {

    switch type {
        case .date:
            return match(piped, type)?.date
        default:
            return nil
    }

}

/// Convert
///
/// let interval: TimeInterval? = "tomorrow at 8 UTC+4" | .date
///
@inline(__always)
public
func |(string: String?,
       type: NSTextCheckingResult.CheckingType) -> TimeInterval? {

    switch type {
        case .date:
            return match(string, type)?.duration
        default:
            return nil
    }

}

/// Convert
///
/// let address: [NSTextCheckingKey: String]? = "1 InfiniteLoop in Cupertino" | .address
///
@inline(__always)
public
func |(string: String?,
       type: NSTextCheckingResult.CheckingType) -> [NSTextCheckingKey: String]? {

    switch type {
        case .address:
            return match(string, type)?.addressComponents
        default:
            return nil
    }

}

/// Convert
///
/// let url: URL? = "1 Infiupht//www.apple.com California, United" | .link
///
@inline(__always)
public
func |(string: String?,
       type: NSTextCheckingResult.CheckingType) -> URL? {

    switch type {
        case .link:
            return match(string, type)?.url
        default:
            return nil
    }

}

/// Convert
///
/// let phoneNumber: String? = "1 Inffornia +19323232444,States" | .phoneNumber
///
@inline(__always)
public
func |(string: String?,
       type: NSTextCheckingResult.CheckingType) -> String? {

    switch type {
        case .phoneNumber:
            return match(string, type)?.phoneNumber
        default:
            return nil
    }

}

/// Convert
///
/// let zone: TimeZone? = "1 InfiniteLoop in Cupertino" | .date
///
@inline(__always)
public
func |(string: String?,
       type: NSTextCheckingResult.CheckingType) -> TimeZone? {

    switch type {
        case .date:
            return match(string, type)?.timeZone
        default:
            return nil
    }

}

fileprivate 
func match(_ piped: String?,
                       _ type: NSTextCheckingResult.CheckingType) -> NSTextCheckingResult? {
    guard let piped = piped else {
        return nil
    }

    let detector = try! NSDataDetector(types: type.rawValue)
    return detector.firstMatch(in: piped,
                               options: [],
                               range: (0, piped.count)|)
}

/// Convert
///
/// let result: [NSTextCheckingResult]? = "1 Inffornia +19323232444,States" | ".*"
///
@inline(__always)
public
func |(string: String, pattern: String) -> [NSTextCheckingResult]? {
    try? NSRegularExpression(pattern: pattern, options: [])
        .matches(in: string, options: [], range: (0, string.count)|)
}

/// Convert
///
/// let result: NSTextCheckingResult? = "1 Inffornia +19323232444,States" | ".*"
///
@inline(__always)
public
func |(string: String, pattern: String) -> NSTextCheckingResult? {
    (string | pattern)?.first
}

#endif
