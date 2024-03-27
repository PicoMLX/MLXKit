# MLXKit

MLXKit is a Swift library that provides an [OpenAI compatible API](https://platform.openai.com/docs/api-reference) layer to [MLX](https://github.com/ml-explore/mlx-swift). MLXKit can be used to create MLX servers or incorporated in chat clients.

MLXKit is in development and not intented for production.

## Highlights


### Supported OpenAI API

| | OpenAI API          |
|----|------------------|
| ✅ | [Chat completion](https://platform.openai.com/docs/api-reference/chat) |
| ✅ | [Chat completion streaming](https://platform.openai.com/docs/api-reference/chat/streaming) |
| ❌ | [Vision](https://platform.openai.com/docs/guides/vision) |
| ❌ | [Text to speech](https://platform.openai.com/docs/guides/text-to-speech/text-to-speech) |
| ❌ | [Speech to text](https://platform.openai.com/docs/guides/speech-to-text/speech-to-text) |
| ❌ | [Moderation](https://platform.openai.com/docs/guides/moderation/moderation) |
| ❌ | [Images](https://platform.openai.com/docs/api-reference/images) |
| ❌ | [Assistants (beta)](https://platform.openai.com/docs/api-reference/assistants) |
| ❌ | [Embeddings](https://platform.openai.com/docs/api-reference/embeddings) | 
| ❌ | [Fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning) | 

### Supported MLX models

See [MLX Community on HuggingFace](https://huggingface.co/mlx-community)

## Installation
The MLXKit package can be built from Xcode or SwiftPM.

In Xcode you can add https://github.com/ronaldmannak/MLXkit as a package dependency.

### Requirements
- MLX is only available on devices running macOS >= 13.5 It is highly recommended to use macOS 14 (Sonoma)



