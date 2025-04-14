import Foundation

public struct OpenAIRequest: Encodable {
    public let model: String = "gpt-4o"
    public let messages: [OpenAIMessage]
    public let max_tokens: Int = 500
    
    public init(messages: [OpenAIMessage]) {
        self.messages = messages
    }
}

public struct OpenAIMessage: Encodable {
    public let role: String
    public let content: [OpenAIContent]
    
    public init(role: String, content: [OpenAIContent]) {
        self.role = role
        self.content = content
    }
}

public struct OpenAIContent: Encodable {
    public let type: String
    public let text: String?
    public let image_url: ImageURL?
    
    public init(type: String, text: String? = nil, image_url: ImageURL? = nil) {
        self.type = type
        self.text = text
        self.image_url = image_url
    }
    
    public static func text(type: String, text: String) -> Self {
        .init(type: type, text: text, image_url: nil)
    }
    
    public static func image(type: String, imageUrl: ImageURL) -> Self {
        .init(type: type, text: nil, image_url: imageUrl)
    }
}

// MARK: - Response

public struct OpenAIResponse: Decodable {
    public struct Choice: Decodable {
        public let message: Message
        
        public struct Message: Decodable {
            public let content: String
        }
    }
    
    public let choices: [Choice]
}

// MARK: - Errors

public enum OpenAIError: Error {
    case failedToConvertImage
    case invalidResponse
}
