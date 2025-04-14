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

public extension AppConstants {
    enum Endpoints {
        case openAIUrl
        
        
        public var url: String {
            switch self {
                
            case .openAIUrl:
                "https://api.openai.com/v1/chat/completions"
            }
        }
    }
}
