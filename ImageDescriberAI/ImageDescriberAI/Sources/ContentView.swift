import ImageScannerUI
import OpenAIProvider
import SwiftUI
import Utilities

public struct ContentView: View {
    
    let key: String
    
    public init() {
        let apiKey = Env["OPENAI_API_KEY"] ?? ""
        key = apiKey
    }

    public var body: some View {
        ScannerView(aiService: OpenAIService(apiKey: key))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
