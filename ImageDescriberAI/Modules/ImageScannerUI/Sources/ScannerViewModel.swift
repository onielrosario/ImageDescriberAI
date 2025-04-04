import SwiftUI
import PhotosUI

public final class ScannerViewModel: ObservableObject {
    @Published public var selectedImage: UIImage?
    @Published public var scanResult: String?
    @Published public var isLoading = false
    
    public init() {}
    
    public func scanImage() async {
        guard selectedImage != nil else { return }
        isLoading = true
        
        do {
            try await Task.sleep(for: .seconds(1.5))
            self.scanResult = "This looks like a placeholder description for a scanner image."
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


