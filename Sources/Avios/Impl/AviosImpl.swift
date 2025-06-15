//
//  Avios.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

import Foundation

enum AviosError: Error {
    /// Error with parsing stringified url
    case invalidRequest
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case update = "UPDATE"
    case put = "PUT"
    case delete = "DELETE"
}

/// This protocol describes all available HTTP-related methods on Avios
protocol HttpMethodDelegate {
    @available(iOS 13, *) func get(_ url: String, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func post(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func post<Body : Encodable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func patch(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func patch<Body : Encodable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func update(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func update<Body : Encodable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func put(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func put<Body : Encodable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func delete(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func delete<Body : Encodable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
}

typealias Headers = [String: String]
typealias AviosResponse = (Data, URLResponse)

/// Elegant implementation of networking, using concepts from  axios (JavaScript library)
@available(macOS 13, *)
@available(iOS 13, *)
class Avios: NSObject, URLSessionTaskDelegate, HttpMethodDelegate, @unchecked Sendable {
    private var defaultHeaders: Headers
    
    /// Generate Avios client with default options
    override init() {
        self.defaultHeaders = [
            "Content-Type": "application/json"
        ]
    }
    
    /// Shared instance of Avios
    static let shared: Avios = Avios()
    
    /// This method generates ready-to-use URLRequest object
    private func createRequest(
        from url: String,
        method: HttpMethod,
        headers: Headers? = nil
    ) throws -> URLRequest {
        // Try parsing stringified url. If it fails, throw an error
        guard let targetUrl = URL(string: url) else { throw AviosError.invalidRequest }
        // Form request with provided arguments
        var request = URLRequest(url: targetUrl)
        
        // Setup HTTP method
        request.httpMethod = method.rawValue
        
        // Apply all headers
        if let headers = headers {
            for (name, value) in defaultHeaders {
                request.setValue(value, forHTTPHeaderField: name)
            }
            
            for (name, value) in headers {
                request.setValue(value, forHTTPHeaderField: name)
            }
        }
        
        // Return modified request
        return request
    }
    
    /// Define custom HTTP Request
    func custom(
        _ url: String,
        method: HttpMethod,
        headers: Headers? = nil
    ) async throws -> AviosResponse {
        // Generate request
        let request = try createRequest(from: url, method: method, headers: headers)
        // Get result from HTTP Request
        let result: AviosResponse = try await URLSession.shared.data(for: request)
        return result
    }
    
    /// Define custom HTTP Request with body
    func custom<Body : Encodable>(
        _ url: String,
        method: HttpMethod,
        body: Body,
        headers: Headers? = nil
    ) async throws -> AviosResponse {
        // Generate request
        var request = try createRequest(from: url, method: method, headers: headers)
        
        // Encode the body
        let encoder = JSONEncoder()
        let data = try encoder.encode(body)
        // Apply body to request
        request.httpBody = data
        
        // Get result from HTTP Request
        let result: AviosResponse = try await URLSession.shared.data(for: request)
        return result
    }
    
    func get(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .get, headers: headers)
    }
    
    func post(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .post, headers: headers)
    }
    
    func post<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .post, body: body, headers: headers)
    }
    
    func patch(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .patch, headers: headers)
    }
    
    func patch<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .patch, body: body, headers: headers)
    }
    
    func update(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .update, headers: headers)
    }
    
    func update<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .update, body: body, headers: headers)
    }
    
    func put(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .put, headers: headers)
    }
    
    func put<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .put, body: body, headers: headers)
    }
    
    func delete(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .delete, headers: headers)
    }
    
    func delete<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .delete, body: body, headers: headers)
    }
}
