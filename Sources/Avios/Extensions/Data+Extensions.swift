//
//  Data+Extensions.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

import SwiftUI

extension Data {
    /**
     Helper method. Tries to decode self into given type.
     
     ```swift
     // Example
     struct User {
        id: Int
        name: String
     }
     
    func decodeUsers(users: Data) throws -> [User] {
        let res: [User] = try users.decode(into: [User].self)
        return res
     }
     ```
     */
    func decode<D : Decodable>(into: D.Type) throws -> D {
        let decoder = JSONDecoder()
        let result: D = try decoder.decode(into, from: self)
        return result
    }
}
