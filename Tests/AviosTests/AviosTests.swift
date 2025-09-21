import Testing
@testable import Avios

struct Post: Codable, Hashable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

fileprivate struct PostDto: Codable {
    var title: String
    var body: String
    var usedId: Int
}

fileprivate struct NonPost: Codable {
    var nonPostId: Int
}

/// Generates typicode endpoint.
/// ```swift
/// // Argument have to be not starting with slash
/// let getPostsEndpoint: String = typicodeUrl("posts")
/// ```
func typicodeUrl(_ route: String) -> String {
    return "https://jsonplaceholder.typicode.com/\(route)"
}

fileprivate func expectThatOk(_ route: String = "posts", method: HttpMethod, statusCode: Int = 200) async throws {
    let (_, res) = try await Avios.shared.custom(typicodeUrl(route), method: method)
    #expect(res.isOk())
    #expect(res.httpResponse?.statusCode == statusCode)
}

struct MainTests {
    @Test func getMethod() async throws {
        let (data, response) = try await Avios.shared.get(typicodeUrl("posts"))
        
        // Response have to be fine here
        #expect(response.isOk())
        
        // Trying to decode posts here
        let posts = try data.decode(into: [Post].self)
        
        // Array should be non-empty
        #expect(posts.count > 0)
    }

    @Test func getSinglePost() async throws {
        let (data, response) = try await Avios.shared.get(typicodeUrl("posts/2"))
        
        // Response have to be fine here
        #expect(response.isOk())
        
        // Trying to decode posts here
        _ = try data.decode(into: Post.self)
        
        // Code below should fail
        #expect(throws: Error.self) {
            _ = try data.decode(into: NonPost.self)
        }
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

    @Test func withBody() async throws {
        let body = PostDto(title: "foo", body: "bar", usedId: 1)
        let (data, res) = try await Avios.shared.post(typicodeUrl("posts"), body: body, headers: [
            "Content-type": "application/json; charset=UTF-8"
        ])
        
        // Check status
        #expect(res.isOk())
        #expect(res.httpResponse?.statusCode == 201)
        
        // Decoding the result
        let result = try data.decode(into: PostDto.self)
        
        #expect(body.body == result.body)
        #expect(body.title == result.title)
    }
}
