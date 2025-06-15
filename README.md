<div align="center">
<img src="https://github.com/user-attachments/assets/de48d27d-8169-4d4a-a4f9-31e7f62b1922" style="max-width:500px" />
<h1>Avios</h1>
</div>

Native networking solution that uses concepts from [Axios.js](https://axios-http.com/docs/intro)

## Usage

### Body-less request

```swift
import Avios

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

func fetchPosts() async throws {
    // Getting data
    // Available methods are: .get, .post, .patch, .update, .put, .delete
    let (data, response) = try await Avios.shared.get("https://jsonplaceholder.typicode.com/posts", headers: nil)
    
    // Handling response
    guard response.isOk() else { throw Error }
    
    // Handling status code
    switch response.httpResponse?.statusCode {
    case 200:
        print("Status code is 200 (OK)")
    case 201:
        print("Status code is 201 (CREATED)")
    // etc...
    }
    
    // Decoding data
    let posts = try data.decode(into: [Post].self)
    return posts
}
```
