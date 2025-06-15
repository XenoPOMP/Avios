import Testing
@testable import Avios

fileprivate struct Post: Codable, Hashable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

@Test func getMethod() async throws {
    let (data, response) = try await Avios.shared.get("https://jsonplaceholder.typicode.com/posts", headers: nil)
    
    // Response have to be fine here
    #expect(response.isOk())
    
    // Trying to decode posts here
    let posts = try data.decode(into: [Post].self)
    
    // Array should be non-empty
    #expect(posts.count > 0)
}
