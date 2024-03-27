//
//  LogPorbs.swift
//
//
//  Created by Ronald Mannak on 3/27/24.
//

import Foundation

/// Log probability information for the choice.
/// # See also
/// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
public struct LogProbs: Codable {
    struct Content: Codable {
        
        /// The token
        /// # See also
        /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
        let token: String
        
        /// The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value -9999.0 is used to signify that the token is very unlikely.
        /// # See also
        /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
        let logprob: Float
        
        /// A list of integers representing the UTF-8 bytes representation of the token. Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
        /// # See also
        /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
        let bytes: [Int]?
        
        /// List of the most likely tokens and their log probability, at this token position. In rare cases, there may be fewer than the number of requested `top_logprobs` returned.
        /// # See also
        /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
        let topLogprobs: [Content]?
    }
    
    /// A list of message content tokens with log probability information.
    /// # See also
    /// [OpenAI API Reference](https://platform.openai.com/docs/api-reference/chat/object)
    let content: [Content]?
}
