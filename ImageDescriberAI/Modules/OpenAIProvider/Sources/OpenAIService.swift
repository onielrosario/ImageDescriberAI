import AIDescriptionService
import SharedModels
import Utilities
import UIKit

public final class OpenAIService: AIServiceInterface {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func describe(image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw OpenAIError.failedToConvertImage
        }
        
        let base64 = imageData.base64EncodedString()
        
        guard let url = URL(string: AppConstants.Endpoints.openAIUrl.url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = OpenAIRequest(messages: [
            .init(role: "user", content: [
                .text(type: "text", text: "What’s in this image? Describe it in detail."),
                .image(type: "image_url", imageUrl: .init(url: "data:image/jpeg;base64,\(base64)"))
            ])
        ])
        
        request.httpBody = try JSONEncoder().encode(payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw OpenAIError.invalidResponse
        }
        
        
        let decodedData = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return decodedData.choices.first?.message.content ?? "No response."
    }
}
