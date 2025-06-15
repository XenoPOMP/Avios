//
//  HttpMethodDelegate.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

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
