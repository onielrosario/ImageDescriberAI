import SwiftUI
import PhotosUI

public struct ScannerView: View {
    @StateObject private var viewModel = ScannerViewModel()
    @State private var selectedItem: PhotosPickerItem?

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // MARK: - Header
                HStack(spacing: 8) {
                    Text("🧠")
                    Text("Image Describer")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top, 32)

                // MARK: - Image
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 250)
                        .overlay(
                            Text("No image selected")
                                .foregroundColor(.gray)
                        )
                }

                // MARK: - Actions
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("📷 Pick an Image")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
                .onChange(of: selectedItem) { _, newItem in
                    guard let item = newItem else { return }

                    Task {
                        do {
                            if let data = try await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                await MainActor.run {
                                    viewModel.selectedImage = uiImage
                                    viewModel.scanResult = nil
                                }
                            }
                        } catch {
                            print("❌ Failed to load image data: \(error)")
                        }
                    }
                }

                Button {
                    Task {
                        await viewModel.scanImage()
                    }
                } label: {
                    if viewModel.scanResult != nil {
                        Label("Already Scanned ✅", systemImage: "checkmark.seal")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    } else {
                        Label("Scan Image", systemImage: "brain.head.profile")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .disabled(viewModel.selectedImage == nil || viewModel.isLoading || viewModel.scanResult != nil)

                if viewModel.isLoading {
                    ProgressView("Analyzing image...")
                        .padding()
                }

                // MARK: - Result Card
                if let result = viewModel.scanResult {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Result:", systemImage: "pencil.and.outline")
                            .font(.headline)

                        Text(result)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
            .padding(.horizontal)
        }
    }
}
