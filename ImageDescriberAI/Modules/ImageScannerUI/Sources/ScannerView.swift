import SwiftUI
import PhotosUI

public struct ScannerView: View {
    @StateObject private var viewModel = ScannerViewModel()
    @State private var selectedItem: PhotosPickerItem?

    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            Text("🧠 Image Describer")
                .font(.largeTitle)
                .bold()

            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(Text("No image selected").foregroundColor(.gray))
            }

            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Pick an Image")
            }
 
            .onChange(of: selectedItem) { (_, newItem) in
                Task {
                    await viewModel.handlePickedItem(newItem)
                }
            }

            Button("Scan Image") {
                Task {
                    await viewModel.scanImage()
                }
            }
            .disabled(viewModel.selectedImage == nil || viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView("Scanning...")
            }

            if let result = viewModel.scanResult {
                Text("📝 Result: \(result)")
                    .padding()
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding()
    }
}
