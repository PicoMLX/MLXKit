import XCTest
@testable import MLXKit

final class CompletionChunkTests: XCTestCase {
    
    // Example chunks source: https://platform.openai.com/docs/api-reference/chat/streaming
    let chunk1 = """
        {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-3.5-turbo-0125", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{"role":"assistant","content":""},"logprobs":null,"finish_reason":null}]}
        """.data(using: .utf8)!

    let chunk2 = """
        {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-3.5-turbo-0125", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{"content":"Hello"},"logprobs":null,"finish_reason":null}]}
        """.data(using: .utf8)!
    
    let chunk3 = """
        {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-3.5-turbo-0125", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{},"logprobs":null,"finish_reason":"stop"}]}
        """.data(using: .utf8)!
    
    let jsonDecoder = JSONDecoder()
    
    override func setUp() {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func testChunkDecoding() throws {
        let c1 = try jsonDecoder.decode(CompletionChunk.self, from: chunk1)
        let c2 = try jsonDecoder.decode(CompletionChunk.self, from: chunk2)
        let c3 = try jsonDecoder.decode(CompletionChunk.self, from: chunk3)
        
        XCTAssertEqual(c1.systemFingerprint, c2.systemFingerprint)
        XCTAssertEqual(c2.systemFingerprint, c3.systemFingerprint)
        XCTAssertEqual(c1.model, "gpt-3.5-turbo-0125")
        XCTAssertEqual(c2.model, "gpt-3.5-turbo-0125")
        XCTAssertEqual(c3.model, "gpt-3.5-turbo-0125")
    }
}
