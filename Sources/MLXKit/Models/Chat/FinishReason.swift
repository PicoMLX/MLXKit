//
//  FinishReason.swift
//
//
//  Created by Ronald Mannak on 3/27/24.
//

import Foundation

/// Every response will include a finish_reason. The possible values for finish_reason are:
/// stop: API returned complete message, or a message terminated by one of the stop sequences provided via the stop parameter
/// length: Incomplete model output due to max_tokens parameter or token limit
/// function_call: The model decided to call a function (deprecated)
/// content_filter: Omitted content due to a flag from our content filters
/// null: API response still in progress or incomplete
/// # See also
/// [OpenAI API Reference](https://platform.openai.com/docs/guides/text-generation/chat-completions-response-format)
enum FinishReason: String, Codable {
    case stop
    case length
    case functionCall = "function_call"
    case contentFilter = "content_filter"
}
