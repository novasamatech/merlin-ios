import Foundation

public struct RaiseSignParams {
    public let publicKey: Data
    public let secret: Data
    public let message: Data
    
    public init(
        publicKey: Data,
        secret: Data,
        message: Data
    ) {
        self.publicKey = publicKey
        self.secret = secret
        self.message = message
    }
}

public protocol RaiseTranscriptApiProtocol {
    func signeMessage(for params: RaiseSignParams) throws -> Data
}

public enum MerlinTranscriptApiError: Error {
    case badResult
}

public final class RaiseTranscriptApi {
    public init() {}
}

public extension RaiseTranscriptApi {
    func signeMessage(for params: RaiseSignParams) throws -> Data {
        let result = try internalSignRaiseTranscript(
            params.publicKey.base64EncodedString().intoRustString(),
            params.secret.base64EncodedString().intoRustString(),
            params.message.base64EncodedString().intoRustString()
        )
        
        guard let signature = Data(base64Encoded: result.toString()) else {
            throw MerlinTranscriptApiError.badResult
        }
        
        return signature
    }
}
