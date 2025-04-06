public enum AppConstants {}

public extension AppConstants {
    enum ImageScannerUI {
        case scannerView
        
        public var title: String {
            switch self {
            case .scannerView:
                "🧠 Image Describer"
            }
        }
    }
}
