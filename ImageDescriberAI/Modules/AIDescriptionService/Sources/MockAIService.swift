import UIKit

public final class MockAIService: AIServiceInterface {
    public init() {}

    public func describe(image: UIImage) async throws -> String {
        try await Task.sleep(for: .seconds(1.0)) // Simulated processing time
        return "Mock description: This image looks like something interesting!"
    }
}
