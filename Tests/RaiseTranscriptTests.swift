import XCTest
import MerlinTranscriptApi

final class RaiseTranscriptTests: XCTestCase {
    func testSign() {
        do {
            let params = RaiseSignParams(
                publicKey: Data(base64Encoded: "LGkwiHxFagl7Qhy/NkivqfRDBpjNmYhSxCNLq0Gxo08=")!,
                secret: Data(base64Encoded: "8Amn4hbV4udnkW33Hr3LOvNN1Va0CMg1Be+9cI9rHQ9j8zwBYK8pvO0Un+3g48afQPvXBSE9i5U44o0q9p9K1g==")!,
                message: Data(base64Encoded: "dcS8yBIKb6WJsv244QGY2NWPBChxTExvAsZCgR62Q4Y=")!
            )
            
            let signature = try RaiseTranscriptApi().signeMessage(for: params)
            
            print("Signature: \(signature.base64EncodedString())")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
}
