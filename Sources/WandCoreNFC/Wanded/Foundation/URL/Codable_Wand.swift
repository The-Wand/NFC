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

import Foundation
import Wand

extension Data {

    @inline(__always)
    postfix
    public
    static
    func |<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }

    @inline(__always)
    postfix
    public
    static
    func |(raw: Self) throws -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: raw, options: []) as? [String : Any]
    }

    @inline(__always)
    postfix
    public
    static
    func |(raw: Self) throws -> [Any]? {
        try? JSONSerialization.jsonObject(with: raw, options: []) as? [Any]
    }

}

extension Dictionary {

    @inline(__always)
    postfix
    public
    static
    func |(p: Self) -> Data {
        try! JSONSerialization.data(withJSONObject: p, options: [])
    }

}

extension Array {

    @inline(__always)
    postfix
    public
    static
    func |(p: Self) -> Data {
        try! JSONSerialization.data(withJSONObject: p, options: [])
    }

}
