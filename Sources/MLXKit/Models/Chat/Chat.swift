//
//  Chat.swift
//
//
//  Created by Ronald Mannak on 3/25/24.
//

import Foundation

/// Chat as received by MLXKit from client
/// Reference: https://platform.openai.com/docs/api-reference/chat
/// POST https://localhost/v1/chat/completions
public struct Chat: Codable {
    
    /// Name of the model to use.
    /// Example: `mlx-community/Nous-Hermes-2-Mistral-7B-DPO-4bit-MLX`
    /// # See also
    ///  [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-model)
    /// # Remarks
    /// Required
    public let model: String
    
    /// A list of messages comprising the conversation so far.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages)
    /// # Remarks
    /// Required
    public let messages: [Message]
        
    // MARK: - Optional properties with default values
    
    /// If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a data: [DONE] message.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-stream)
    /// # Remarks
    /// Optional. Defaults to false
    public let stream: Bool
    
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    /// We generally recommend altering this or top_p but not both.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-temperature)
    /// # Remarks
    /// Optional. Defaults to 1
    public let temperature: Float
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    /// We generally recommend altering this or temperature but not both.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-top_p)
    /// # Remarks
    /// Optional. Defaults to 1
    public let topP: Float
    
    /// How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep n as 1 to minimize costs.
    /// # See also
    /// [OpenAI API Referene](https://platform.openai.com/docs/api-reference/chat/create#chat-create-n)
    /// # Remarks
    /// integer on null, optional, Defaults to 1
    public let n: Int
    
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-frequency_penalty)
    /// # Remarks
    /// Optional, Defaults to 0
    public let frequencyPenalty: Float
    
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-presence_penalty)
    /// # Remarks
    /// number or null. Defaults to 0
    public let presencePenalty: Float
    
    /// Whether to return log probabilities of the output tokens or not.
    /// If true, returns the log probabilities of each output token returned in the content of message.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-logprobs)
    /// [OpenAI Cookbook](https://cookbook.openai.com/examples/using_logprobs)
    /// # Remarks
    /// Optional, Defaults to false
    public let logprobs: Bool
    
    // MARK: - Optional values
    
    /// The maximum number of tokens that can be generated in the chat completion.
    /// The total length of input tokens and generated tokens is limited by the model's context length.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-max_tokens)
    /// # Remarks
    /// Integer or null. Optional
    public let maxTokens: Int?
    
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-user)
    /// # Remarks
    /// Optional
    public let user: String?
    
    /// Modify the likelihood of specified tokens appearing in the completion.
    /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer) to an associated bias value from -100 to 100.
    /// Mathematically, the bias is added to the logits generated by the model prior to sampling.
    /// The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-logit_bias)
    /// # Remarks
    /// Optional, Defaults to null
    public let logitBias: [Int: Int]?
    
    /// An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. logprobs must be set to true if this parameter is used.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-top_logprobs)
    /// # Remarks
    /// integer or null
    public let topLogprobs: Int?
    
    /// An object specifying the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models newer than gpt-3.5-turbo-1106.
    /// Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
    /// # Important
    /// Important: when using JSON mode, you must also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format)
    /// # Remarks
    /// Optional
    public let responseFormat: JSONObject?
    
    /// This feature is in Beta. If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the system_fingerprint response parameter to monitor changes in the backend.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-seed)
    /// # Remarks
    /// Optional
    public let seed: Int?
    
    /// Up to 4 sequences where the API will stop generating further tokens.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-stop)
    /// # Remarks
    /// Automatically converts a string to a single-element array if the client passes a string instead of an array.
    public let stop: [String]?
    
    /*
    /// A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for. A max of 128 functions are supported.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools)
    /// # Remarks
    /// Optional
    public let tools: [String]?
    
    /// Controls which (if any) function is called by the model. none means the model will not call a function and instead generates a message. auto means the model can pick between generating a message or calling a function. Specifying a particular function via `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that function.
    /// none is the default when no functions are present. auto is the default if functions are present.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-tool_choice)
    /// # Remarks
    public let toolChoice: ToolChoice?

    /// Deprecated in favor of tool_choice.
    /// Controls which (if any) function is called by the model. none means the model will not call a function and instead generates a message. auto means the model can pick between generating a message or calling a function. Specifying a particular function via `{"name": "my_function"}` forces the model to call that function.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-function_call)
    /// # Remarks
    /// none is the default when no functions are present. auto is the default if functions are present.
    @available(*, deprecated, message: "Use tools instead")
    public let functionCall: FunctionCall?
    
    /// Deprecated in favor of tools.
    /// A list of functions the model may generate JSON inputs for.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/create#chat-create-functions)
    @available(*, deprecated, message: "Use tools instead")
    public let functions: [String]?
    */
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.model = try container.decode(String.self, forKey: .model)
        self.messages = try container.decode([Message].self, forKey: .messages)
        self.stream = try container.decodeIfPresent(Bool.self, forKey: .stream) ?? false
        self.temperature = try container.decodeIfPresent(Float.self, forKey: .temperature) ?? 1
        self.topP = try container.decodeIfPresent(Float.self, forKey: .topP) ?? 1
        self.n = try container.decodeIfPresent(Int.self, forKey: .n) ?? 1
        self.frequencyPenalty = try container.decodeIfPresent(Float.self, forKey: .frequencyPenalty) ?? 0
        self.presencePenalty = try container.decodeIfPresent(Float.self, forKey: .presencePenalty) ?? 0
        self.logprobs = try container.decodeIfPresent(Bool.self, forKey: .logprobs) ?? false
        self.maxTokens = try container.decodeIfPresent(Int.self, forKey: .maxTokens)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.logitBias = try container.decodeIfPresent([Int : Int].self, forKey: .logitBias)
        self.topLogprobs = try container.decodeIfPresent(Int.self, forKey: .topLogprobs)
        self.responseFormat = try container.decodeIfPresent(JSONObject.self, forKey: .responseFormat)
        self.seed = try container.decodeIfPresent(Int.self, forKey: .seed)
        do {
            self.stop = try container.decodeIfPresent([String].self, forKey: .stop)
        } catch {
            self.stop = [try container.decodeIfPresent(String.self, forKey: .stop)].compactMap{ $0 }
        }
    }
}

