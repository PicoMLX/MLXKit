//
//  Message.swift
//
//
//  Created by Ronald Mannak on 3/25/24.
//

import Foundation

/// # See also
/// [OpenAI API Reference create](https://platform.openai.com/docs/api-reference/chat/create)
/// [OpenAI API Reference completion](https://platform.openai.com/docs/api-reference/chat/object)
public struct Message: Codable {
    
    /// The role of the author of this message.
    /// # See also
    /// [OpenAI API Reference create](https://platform.openai.com/docs/api-reference/chat/create)
    /// [OpenAI API Reference completion](https://platform.openai.com/docs/api-reference/chat/object)
    public let role: Role
    
    /// The contents of the message
    /// # See also
    /// [OpenAI API Reference create](https://platform.openai.com/docs/api-reference/chat/create)
    /// [OpenAI API Reference completion](https://platform.openai.com/docs/api-reference/chat/object)
    public let content: String
//    public let content: Content
    // TODO: Add support for multipart content
    
    /// An optional name for the participant. Provides the model information to differentiate between participants of the same role.
    /// # See also
    /// [OpenAI API Reference create](https://platform.openai.com/docs/api-reference/chat/create)
    /// [OpenAI API Reference completion](https://platform.openai.com/docs/api-reference/chat/object)
    public let name: String?
    
    /// The tool calls generated by the model, such as function calls.
    /// # Remarks
    /// - Role must be assistant
    let toolCalls: [ToolCall]?
    
    /// Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model.
    /// # See also
    /// [OpenAI API Reference create](https://platform.openai.com/docs/api-reference/chat/create)
    /// [OpenAI API Reference completion](https://platform.openai.com/docs/api-reference/chat/object)
    @available(*, deprecated, message: "Use tools and ToolChoice instead")
    let functionCall: [FunctionCall]?
}

//https://platform.openai.com/docs/guides/vision