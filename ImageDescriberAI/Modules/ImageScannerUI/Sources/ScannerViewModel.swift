import SwiftUI
import AIDescriptionService
import PhotosUI

@MainActor
public final class ScannerViewModel: ObservableObject {
    @Published public var selectedImage: UIImage?
    @Published public var scanResult: String?
    @Published public var isLoading = false
    
    
    private let aiService: AIServiceInterface
    
    public init(aiService: AIServiceInterface) {
        self.aiService = aiService
    }
    
    public func scanImage() async {
        guard let image = selectedImage else { return }
        isLoading = true
        
        do {
            let description = try await aiService.describe(image: image)
            scanResult = description
        }
        catch {
            self.scanResult = "Scan failed: \(error.localizedDescription)"
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
        } catch {
            print("❌ Failed to load image data: \(error)")
        }
    }
}


