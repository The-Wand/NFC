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
import Foundation.NSData
import Wand

/// Convert
///
/// let data: Data? = url|
///
@inline(__always)
postfix
public
func |(url: URL) -> Data? {
    try? Data(contentsOf: url)
}

/// Convert
///
/// let data: Data? = url|
///
@inline(__always)
postfix
public
func |(url: URL?) -> Data? {
    guard let url else {
        return nil
    }
    
    return url|
}

/// Convert
///
/// let data: Data = string|
///
@inline(__always)
postfix
public 
func |(string: String) -> Data {
    string.data(using: .utf8)!
}

/// Convert
///
/// let data: Data = string | .utf8
///
@inline(__always)
public
func |(string: String, encoding: String.Encoding) -> Data {
    string.data(using: encoding)!
}

/// Convert
///
/// let data: Data = string | .utf8
///
@inline(__always)
postfix
public
func |<T: Codable>(model: T) -> Data {
    try! JSONEncoder().encode(model)
}

@inline(__always)
postfix
public
func |(resource: Wand.Resource) throws -> Data {
    try Data(contentsOf: resource|)
}

@inline(__always)
postfix
public
func |<T: Decodable> (resource: Wand.Resource) throws -> T {
    let data: Data = try Data(contentsOf: resource|)
    return try data|
}

@inline(__always)
postfix
public
func |(resource: Wand.Resource) throws -> [String: Any]? {
    let data: Data = try Data(contentsOf: resource|)
    return try data|
}

#endif
