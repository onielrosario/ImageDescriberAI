import SwiftUI
import AIDescriptionService
import PhotosUI
import Utilities

public struct ScannerView: View {
    @StateObject private var viewModel: ScannerViewModel
    @State private var selectedItem: PhotosPickerItem?

    public init(aiService: AIServiceInterface = MockAIService()) {
        _viewModel = StateObject(wrappedValue: ScannerViewModel(aiService: aiService))
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(AppConstants.ImageScannerUI.scannerView.title)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
                Group {
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
                }
                .animation(.easeInOut, value: viewModel.selectedImage)


                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Pick an Image")
                        .foregroundStyle(Color.blue)
                }
     
//                .onChange(of: $selectedItem) { _, newItem in
//                    Task {
//                        await viewModel.handlePickedItem(newItem)
//                    }
//                }

                Button("Scan Image") {
                    Task {
                        await viewModel.scanImage()
                        let feedback = UINotificationFeedbackGenerator()
                        feedback.notificationOccurred(.success)
                    }
                }
                .disabled(viewModel.selectedImage == nil || viewModel.isLoading)
                .foregroundColor(viewModel.selectedImage == nil || viewModel.isLoading ? .gray : .blue)

                if viewModel.isLoading {
                    ProgressView("Scanning...")
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                else if let result = viewModel.scanResult {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("📝 Result:")
                            .font(.headline)
                        Text(result)
                            .font(.system(.body, design: .rounded))
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(.systemGray6))
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut, value: result)
                }

                Spacer(minLength: 20)
            }
            .padding()
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                await viewModel.handlePickedItem(newItem)
            }
        }
    }
}
