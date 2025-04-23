import Foundation

public enum CloudinaryError: Error {
    case failedToEncode
    case uploadFailed(statusCode: Int)
    case invalidResponse
}

public final class CloudinaryUploader {
    private let cloudName: String
    private let uploadPreset: String

    public init(cloudName: String, uploadPreset: String) {
        self.cloudName = cloudName
        self.uploadPreset = uploadPreset
    }

    public func uploadImage(base64String: String) async throws -> String {
        guard let url = URL(string: "https://api.cloudinary.com/v1_1/\(cloudName)/image/upload") else {
            throw CloudinaryError.invalidResponse
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = try createMultipartBody(base64String: base64String, uploadPreset: uploadPreset, boundary: boundary)

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw CloudinaryError.uploadFailed(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        let result = try JSONDecoder().decode(CloudinaryUploadResponse.self, from: data)
        return result.secure_url
    }
    
    private func createMultipartBody(base64String: String, uploadPreset: String, boundary: String) throws -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        let closingBoundary = "--\(boundary)--\r\n"
        
        guard let boundaryData = boundaryPrefix.data(using: .utf8),
              let fileContentDisposition = "Content-Disposition: form-data; name=\"file\"\r\n\r\n".data(using: .utf8),
              let fileData = "data:image/jpeg;base64,\(base64String)\r\n".data(using: .utf8),
              let presetBoundaryData = boundaryPrefix.data(using: .utf8),
              let presetContentDiposition = "Content-Disposition: form-data; name=\"upload_preset\"\r\n\r\n".data(using: .utf8),
              let presetData = "\(uploadPreset)\r\n".data(using: .utf8),
              let closingBoundaryData = closingBoundary.data(using: .utf8)
        else {
            throw CloudinaryError.failedToEncode
        }
        
        body.append(boundaryData)
        body.append(fileContentDisposition)
        body.append(fileData)
        
        body.append(presetBoundaryData)
        body.append(presetContentDiposition)
        body.append(presetData)
        
        body.append(closingBoundaryData)
        
        return body
    }
}


public struct CloudinaryUploadResponse: Codable {
    public let secure_url: String
}
