import Testing
@testable import Avios

fileprivate struct Post: Codable, Hashable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

/// Generates typicode endpoint.
/// ```swift
/// // Argument have to be not starting with slash
/// let getPostsEndpoint: String = typicodeUrl("posts")
/// ```
fileprivate func typicodeUrl(_ route: String) -> String {
    return "https://jsonplaceholder.typicode.com/\(route)"
}

fileprivate func expectThatOk(_ route: String = "posts", method: HttpMethod, statusCode: Int = 200) async throws {
    let (_, res) = try await Avios.shared.custom(typicodeUrl(route), method: method)
    #expect(res.isOk())
    #expect(res.httpResponse?.statusCode == statusCode)
}

@Test func getMethod() async throws {
    let (data, response) = try await Avios.shared.get(typicodeUrl("posts"), headers: nil)
    
    // Response have to be fine here
    #expect(response.isOk())
    
    // Trying to decode posts here
    let posts = try data.decode(into: [Post].self)
    
    // Array should be non-empty
    #expect(posts.count > 0)
}

@Test func postMethod() async throws {
    try await expectThatOk("posts", method: .post, statusCode: 201)
}

@Test func putMethod() async throws {
    try await expectThatOk("posts/1", method: .put)
}

@Test func patchMethod() async throws {
    try await expectThatOk("posts/1", method: .patch)
}

@Test func deleteMethod() async throws {
    try await expectThatOk("posts/1", method: .delete)
}

@Test func handleStatusCodes() async throws {
    let (_, res) = try await Avios.shared.custom(typicodeUrl("this-path-does-not-exist"), method: .patch)
    #expect(res.httpResponse?.statusCode == 404)
}
