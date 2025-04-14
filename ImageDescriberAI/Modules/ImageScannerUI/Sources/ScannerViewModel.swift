import SwiftUI
import OpenAIProvider
import AIDescriptionService
import PhotosUI
import Utilities

@MainActor
public final class ScannerViewModel: ObservableObject {
    @Published public var selectedImage: UIImage?
    @Published public var scanResult: String?
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    
    private let aiService: AIServiceInterface
    
    public init(aiService: AIServiceInterface = OpenAIService(apiKey: Env["OPENAI_API_KEY"] ?? "")) {
        self.aiService = aiService
    }
    
    public func scanImage() async {
        guard let image = selectedImage else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let description = try await aiService.describe(image: image)
            scanResult = description
        }
        catch {
            errorMessage = "❌ \(error.localizedDescription)"
            scanResult = nil
        }
        
        self.isLoading = false
    }
    
    public func handlePickedItem(_ item: PhotosPickerItem?) async {
        do {
            guard let item,
                  let data = try await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else { return }

            selectedImage = image
            scanResult = nil
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load image data: \(error.localizedDescription)"
        }
    }
}


