import UIKit

public protocol AIServiceInterface: AnyObject {
    func describe(image: UIImage) async throws -> String
}

public final class AIService: AIServiceInterface {
    
    
    public func describe(image: UIImage) async throws -> String {
        ""
    }
}
