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
import Foundation
import Wand

@available(visionOS, unavailable)
public
protocol Rest_Model: Model, Codable {

    static 
    var base: String? {get}
    static
    var path: String {get}

    static 
    var headers: [String : String]? {get}

}

@available(visionOS, unavailable)
extension Rest_Model {

    public
    static
    var path: String? {
        nil
    }
    
    public
    static
    var headers: [String : String]? {
        nil
    }
    
}

public
extension Ask {

    class Get: Ask {
    }

    class Post: Ask {
    }

    class Put: Ask {
    }

    class Delete: Ask {
    }

}

@available(visionOS, unavailable)
public
extension Ask where T: Rest.Model {

    static 
    func get(handler: @escaping (T)->() ) -> Get {
        .one(handler: handler)
    }

    static 
    func post(handler: @escaping (T)->() ) -> Post {
        Post.one(handler: handler)
    }

    static 
    func put(handler: @escaping (T)->() ) -> Put {
        .one(handler: handler)
    }

    static 
    func delete(handler: @escaping (T)->() ) -> Delete {
        .one(handler: handler)
    }

}

#endif
