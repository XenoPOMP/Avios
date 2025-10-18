//
//  BaseUrlTests.swift
//  Avios
//
//  Created by Александр on 21.09.2025.
//

import Testing
@testable import Avios

struct BaseUrlTests {

    func testPosts(_ fetcher: () async throws -> AviosResponse) async throws {
        let (data, response) = try await fetcher()
        // Response have to be fine here
        #expect(response.isOk())
        
        // Trying to decode posts here
        let posts: [Post] = try JSON.parse(data)
        
        // Array should be non-empty
        #expect(posts.count > 0)
    }
    
    @Test func defaultBaseUrl() async throws {
        try await testPosts {
            try await Avios.shared.get(typicodeUrl("posts"))
        }
    }
    
    @Test func instanceCreationWithDefaultUrl() async throws {
        try await testPosts {
            let apiClient: Avios = Avios(baseUrl: "https://jsonplaceholder.typicode.com/")
            return try await apiClient.get("posts")
        }
    }
    
    @Test func dedupeSlashes() async throws {
        try await testPosts {
            let apiClient: Avios = Avios(baseUrl: "https://jsonplaceholder.typicode.com/")
            return try await apiClient.get("/posts")
        }
        
        try await testPosts {
            let apiClient: Avios = Avios(baseUrl: "https://jsonplaceholder.typicode.com/")
            return try await apiClient.get("//posts")
        }
    }

}
