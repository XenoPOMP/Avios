<div align="center">
<img src="https://github.com/user-attachments/assets/de48d27d-8169-4d4a-a4f9-31e7f62b1922" style="max-width:500px" />
<h1>Avios</h1>
</div>

![GitHub Tag](https://img.shields.io/github/v/tag/XenoPOMP/Avios?label=Version&color=blue)
![Static Badge](https://img.shields.io/badge/Swift-v6.1.0-%23F05138)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/XenoPOMP/Avios/swift.yml?label=Tests)

<hr/>

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

### Requests with body
```swift
struct PostDto: Codable {
    var title: String
    var body: String
    var usedId: Int
}

let body = PostDto(title: "foo", body: "bar", usedId: 1)

// The logic is the same as written before, but you have to pass
// body argument that conforms to Encodable
let (data, res) = try await Avios.shared.post(typicodeUrl("posts"), body: body, headers: [
    "Content-type": "application/json; charset=UTF-8"
])
```

## Todo
- [ ] Base URL option
