import XCTest
@testable import MLXKit

final class ChatTests: XCTestCase {
    
    let defaultInput = """
        {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "system",
                "content": "You are a helpful assistant."
              },
              {
                "role": "user",
                "content": "Hello!"
              }
            ]
        }
        """.data(using: .utf8)!
    
    let streamingInput = """
      {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant."
          },
          {
            "role": "user",
            "content": "Hello!"
          }
        ],
        "stream": true
      }
      """.data(using: .utf8)!
    
    let imageInput = """
        {
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": "What’s in this image?"
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
              }
            }]
          }],
          "max_tokens": 300
        }
        """.data(using: .utf8)!
    
    let imageInput2 = """
        {
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": "What’s in this image?"
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "data:image/jpeg;base64,{base64_image}"
              }
            }]
          }],
          "max_tokens": 300
        }
        """.data(using: .utf8)!
    
    let imageInput3 = """
        {
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": "What are in these images? Is there any difference between them?",
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
                },
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
                },
            }]
          }],
          "max_tokens": 300
        }
        """.data(using: .utf8)!
    
    let functionInput = """
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": "What is the weather like in Boston?"
            }
          ],
          "tools": [
            {
              "type": "function",
              "function": {
                "name": "get_current_weather",
                "description": "Get the current weather in a given location",
                "parameters": {
                  "type": "object",
                  "properties": {
                    "location": {
                      "type": "string",
                      "description": "The city and state, e.g. San Francisco, CA"
                    },
                    "unit": {
                      "type": "string",
                      "enum": ["celsius", "fahrenheit"]
                    }
                  },
                  "required": ["location"]
                }
              }
            }
          ],
          "tool_choice": "auto"
        }
        """.data(using: .utf8)!
    
    let logProbsInput = """
        {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": "Hello!"
              }
            ],
            "logprobs": true,
            "top_logprobs": 2
        }
        """.data(using: .utf8)!
    
    let jsonDecoder = JSONDecoder()
    
    override func setUp() {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func testDefaultDecoding() throws {
        let chat = try jsonDecoder.decode(Chat.self, from: defaultInput)
        
        XCTAssertEqual(chat.model, "gpt-3.5-turbo")
        XCTAssertEqual(chat.messages[0].role, .system)
//        XCTAssertEqual(chat.messages[1].content, .string("Hello!"))
        XCTAssertEqual(chat.messages[1].content, "Hello!")
    }
    
    func testDefaultValues() throws {
        let chat = try jsonDecoder.decode(Chat.self, from: defaultInput)
        
        XCTAssertEqual(chat.temperature, 1)
        XCTAssertEqual(chat.stream, false)
        XCTAssertEqual(chat.topP, 1)
        XCTAssertEqual(chat.n, 1)
        XCTAssertEqual(chat.frequencyPenalty, 0)
        XCTAssertEqual(chat.presencePenalty, 0)
        XCTAssertEqual(chat.logprobs, false)
    }
    
    func testStreamingDecoding() throws {
        let chat = try jsonDecoder.decode(Chat.self, from: streamingInput)
        
        XCTAssertEqual(chat.stream, true)
    }
    
//    func testFunctionDecoding() throws {
//        let chat = try jsonDecoder.decode(Chat.self, from: functionInput)
//        
//        XCTAssertEqual(chat.stream, true)
//    }
 
    func testLogProbDecoding() throws {
        let chat = try jsonDecoder.decode(Chat.self, from: logProbsInput)
        
        XCTAssertEqual(chat.topLogprobs, 2)
        XCTAssertEqual(chat.logprobs, true)
    }
    
//    func testImageDecoding() throws {
//        let chat = try jsonDecoder.decode(Chat.self, from: imageInput)
//        
//        XCTAssertEqual(chat.stream, true)
//    }
}
