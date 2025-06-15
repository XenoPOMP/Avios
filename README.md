<div align="center">
<img src="https://github.com/user-attachments/assets/de48d27d-8169-4d4a-a4f9-31e7f62b1922" style="max-width:500px" />
<h1>Avios</h1>
</div>

Native networking solution that uses concepts from [Axios.js](https://axios-http.com/docs/intro)

## Usage

```swift
func fetchUsers() async throws {
    let (data, response) = try await Avios.shared.get("https://jsonplaceholder.typicode.com/posts", headers: nil)
}
```
