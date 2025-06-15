//
//  URLResponse+Extensions.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

import Foundation

public extension HTTPURLResponse {
    func isResponseOk() -> Bool {
        // OK status codes starts with 2 (2XX)
        return (200...299).contains(self.statusCode)
    }
}

public extension URLResponse {
    func isOk() -> Bool {        
        // Check if response is incorrect format here
        guard let response = self.httpResponse else {
            return false
        }
        
        return response.isResponseOk()
    }
    
    var httpResponse: HTTPURLResponse? {
        guard let response = self as? HTTPURLResponse else {
            return nil
        }
        
        return response
    }
}
