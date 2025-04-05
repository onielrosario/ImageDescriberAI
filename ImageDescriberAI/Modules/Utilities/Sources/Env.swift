import Foundation

public enum Env {
    private static let fileName = ".env"

    public static var env: [String: String]  = {
        guard let url = URL(string: FileManager.default.currentDirectoryPath)?.appendingPathComponent(fileName),
              let content = try? String(contentsOf: url, encoding: .utf8)
        else {
            fatalError("Missing OPENAI_API_KEY")
        }
        
        return content
            .components(separatedBy: .newlines)
            .compactMap { line -> (String, String)? in
                guard line.isEmpty == false,
                        line.hasPrefix("#") == false,
                      let separatorRange = line.range(of: "=")
                else { return nil }
                
                let key = line[..<separatorRange.lowerBound].trimmingCharacters(in: .whitespaces)
                let value = line[separatorRange.upperBound...].trimmingCharacters(in: .whitespaces)
                return (key, value)
            }
            .reduce(into: [String: String]()) { result, pair in
                result[pair.0] = pair.1
            }
    }()
    
    public static subscript(key: String) -> String? {
        env[key]
    }
}
