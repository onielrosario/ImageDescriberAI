//import Foundation
//
//public enum Env {
//    private static let filename = ".env"
//
//    public static var values: [String: String] = {
//        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
//            print("⚠️ .env access during tests. Returning dummy OPENAI_API_KEY.")
//            return ["OPENAI_API_KEY": "test_dummy_key"]
//        }
//        
//        let fsPath = FileManager.default.currentDirectoryPath + "/\(filename)"
//        let fsURL = URL(fileURLWithPath: fsPath)
//
//        if let content = try? String(contentsOf: fsURL, encoding: .utf8) {
//            return parse(content)
//        }
//
//        if let bundledURL = Bundle.main.url(forResource: filename, withExtension: nil),
//           let content = try? String(contentsOf: bundledURL, encoding: .utf8) {
//            return parse(content)
//        }
//
//        fatalError("❌ Could not find .env file in file system or bundle")
//    }()
//
//    public static subscript(key: String) -> String? {
//        values[key]
//    }
//
//    private static func parse(_ content: String) -> [String: String] {
//        content
//            .components(separatedBy: .newlines)
//            .compactMap { line -> (String, String)? in
//                guard !line.isEmpty,
//                      !line.hasPrefix("#"),
//                      let separatorRange = line.range(of: "=") else { return nil }
//
//                let key = line[..<separatorRange.lowerBound].trimmingCharacters(in: .whitespaces)
//                let value = line[separatorRange.upperBound...].trimmingCharacters(in: .whitespaces)
//                return (key, value)
//            }
//            .reduce(into: [:]) { $0[$1.0] = $1.1 }
//    }
//}
