import AIDescriptionService
import ImageUploader
import SharedModels
import Utilities
import UIKit

public final class OpenAIService: AIServiceInterface {
    
    public init() {}
    
    public func describe(image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw OpenAIError.failedToConvertImage
        }
        
        let base64 = imageData.base64EncodedString()
        
        // 3. Upload to Cloudinary and get public URL
        let uploader = CloudinaryUploader(cloudName: "doshl1dwe", uploadPreset: "describerAI")
        print("[DEBUG] Uploading image to Cloudinary...")
        let imageUrl = try await uploader.uploadImage(base64String: base64)
        print("[DEBUG] Cloudinary URL:", imageUrl)
        guard let baseUrl = URL(string: AppConstants.Endpoints.openAIUrl.url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = OpenAIRequest(messages: [
            .init(role: "user", content: [
                .text(type: "text", text: "What’s in this image? Describe it in detail."),
                .image(type: "image_url", imageUrl: .init(url: imageUrl))
            ])
        ])
        
        request.httpBody = try JSONEncoder().encode(payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("[OPENAI] Status:", httpResponse.statusCode)
            print("[OPENAI] Response body:", String(data: data, encoding: .utf8) ?? "no body")
            
            guard httpResponse.statusCode == 200 else {
                throw OpenAIError.invalidResponse
            }
        }
        
        
        let decodedData = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return decodedData.choices.first?.message.content ?? "No response."
    }
}
