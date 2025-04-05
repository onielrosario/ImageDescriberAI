import Foundation

struct OpenAIRequest: Encodable {
    let model: String = "gpt-4-vision-preview"
    let messages: [OpenAIMessage]
    let max_tokens: Int = 500
}

struct OpenAIMessage: Encodable {
    let role: String
    let content: [OpenAIContent]
}

struct OpenAIContent: Encodable {
    let type: String
    let text: String?
    let image_url: ImageURL?

    static func text(type: String, text: String) -> Self {
        .init(type: type, text: text, image_url: nil)
    }

    static func image(type: String, imageUrl: ImageURL) -> Self {
        .init(type: type, text: nil, image_url: imageUrl)
    }
}

struct ImageURL: Encodable {
    let url: String
}

// MARK: - Response

struct OpenAIResponse: Decodable {
    struct Choice: Decodable {
        let message: Message

        struct Message: Decodable {
            let content: String
        }
    }

    let choices: [Choice]
}

// MARK: - Errors

enum OpenAIError: Error {
    case failedToConvertImage
    case invalidResponse
}
