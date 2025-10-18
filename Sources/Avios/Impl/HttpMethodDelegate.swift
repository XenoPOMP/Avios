//
//  HttpMethodDelegate.swift
//  Avios
//
//  Created by Александр on 15.06.2025.
//

/// This protocol describes all available HTTP-related methods on Avios
public protocol HttpMethodDelegate {
    @available(iOS 13, *) func get(_ url: String, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func post(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func post<Body : Codable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func patch(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func patch<Body : Codable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func update(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func update<Body : Codable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func put(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func put<Body : Codable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
    
    @available(iOS 13, *) func delete(_ url: String, headers: Headers?) async throws -> AviosResponse
    @available(iOS 13, *) func delete<Body : Codable>(_ url: String, body: Body, headers: Headers?) async throws -> AviosResponse
}
