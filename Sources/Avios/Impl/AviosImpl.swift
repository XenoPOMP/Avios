//
//  Avios.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

import Foundation

public enum AviosError: Error {
    /// Error with parsing stringified url
    case invalidRequest
}

public class AviosDefaults {
    public static let headers: Headers = [
        "Content-Type": "application/json"
    ]
    
    public static let baseUrl: String? = nil
}

/// Elegant implementation of networking, using concepts from  axios (JavaScript library)
@available(macOS 13, *)
@available(iOS 13, *)
public class Avios: NSObject, URLSessionTaskDelegate, HttpMethodDelegate, @unchecked Sendable {
    private var defaultHeaders: Headers
    private var baseUrl: String?
    
    public init(
        defaultHeaders: Headers = AviosDefaults.headers,
        baseUrl: String? = nil
    ) {
        self.defaultHeaders = defaultHeaders
        self.baseUrl = baseUrl
    }
    
    /// Shared instance of Avios
    public static let shared: Avios = Avios()
    
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
    public func custom(
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
    public func custom<Body : Encodable>(
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
    
    public func get(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .get, headers: headers)
    }
    
    public func post(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .post, headers: headers)
    }
    
    public func post<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .post, body: body, headers: headers)
    }
    
    public func patch(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .patch, headers: headers)
    }
    
    public func patch<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .patch, body: body, headers: headers)
    }
    
    public func update(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .update, headers: headers)
    }
    
    public func update<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .update, body: body, headers: headers)
    }
    
    public func put(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .put, headers: headers)
    }
    
    public func put<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .put, body: body, headers: headers)
    }
    
    public func delete(_ url: String, headers: Headers?) async throws -> AviosResponse {
        try await self.custom(url, method: .delete, headers: headers)
    }
    
    public func delete<Body>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse where Body : Encodable {
        try await self.custom(url, method: .delete, body: body, headers: headers)
    }
}
