import XCTest
@testable import MLXKit

final class CompletionTests: XCTestCase {
    
    let completion1 = """
        {
          "choices": [
            {
              "finish_reason": "stop",
              "index": 0,
              "message": {
                "content": "The 2020 World Series was played in Texas at Globe Life Field in Arlington.",
                "role": "assistant"
              },
              "logprobs": null
            }
          ],
          "created": 1677664795,
          "id": "chatcmpl-7QyqpwdfhqwajicIEznoc6Q47XAyW",
          "model": "gpt-3.5-turbo-0613",
          "object": "chat.completion",
          "usage": {
            "completion_tokens": 17,
            "prompt_tokens": 57,
            "total_tokens": 74
          }
        }
        """.data(using: .utf8)!
    
    // Example from https://platform.openai.com/docs/api-reference/chat/create
    let completion2 = """
        {
          "id": "chatcmpl-123",
          "object": "chat.completion",
          "created": 1677652288,
          "model": "gpt-3.5-turbo-0125",
          "system_fingerprint": "fp_44709d6fcb",
          "choices": [{
            "index": 0,
            "message": {
              "role": "assistant",
              "content": "\\n\\nHello there, how may I assist you today?",
            },
            "logprobs": null,
            "finish_reason": "stop"
          }],
          "usage": {
            "prompt_tokens": 9,
            "completion_tokens": 12,
            "total_tokens": 21
          }
        }
        """.data(using: .utf8)!

    
    let jsonDecoder = JSONDecoder()
    
    override func setUp() {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func testCompletionDecoding() throws {
        let c1 = try jsonDecoder.decode(Completion.self, from: completion1)
        let c2 = try jsonDecoder.decode(Completion.self, from: completion2)

        XCTAssertEqual(c1.model, "gpt-3.5-turbo-0613")
        XCTAssertEqual(c2.model, "gpt-3.5-turbo-0125")        
    }
}
