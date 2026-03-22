# PRD Mixer — Foundation Model Integration

## Overview

PRD Mixer uses Apple's on-device Foundation Model framework (iOS 26+) for AI-powered PRD generation. All inference runs locally — no data leaves the device.

## API Usage

### Import

```swift
#if canImport(FoundationModels)
import FoundationModels
#endif
```

The `#if canImport` guard enables the app to compile on simulators and devices that don't support Foundation Models.

### Session Creation

```swift
let session = LanguageModelSession(instructions: systemPrompt)
```

The `instructions` parameter sets the system prompt that guides the model's behavior. Each generation creates a fresh session.

### Streaming Response

```swift
let stream = session.streamResponse(to: userPrompt, generating: String.self)
for try await partial in stream {
    streamedText = partial  // Updates UI progressively
}
```

The `streamResponse(to:generating:)` method returns an `AsyncSequence` of partial results. Each iteration provides the cumulative text generated so far.

### Availability Check

```swift
guard LanguageModelSession.isAvailable else {
    // Show fallback message
    return
}
```

## Prompt Structure

### PRD Generation

The app uses a single hardcoded system prompt (`DefaultSystemPrompts.generationPromptBody`) that instructs the model to generate a concise, well-formatted Markdown PRD. The prompt is tuned for fun, approachable output with consistent formatting (see `docs/prompt-tuning-test-plan.md` for iteration history).

The user prompt lists selected ingredients in format:
```
📝 TODO List (Category: appType)
📱 iOS (Category: platform)
🐱 Cats (Category: theme)
```

## Error Handling

| Error | Handling |
|-------|----------|
| Model not available | Display message: "Foundation Model is not available on this device" |
| Generation failure | Display error with "Try Again" button |
| User cancellation | Set session to nil, stop generation |

## Simulator Fallback

When `FoundationModels` cannot be imported (simulator, unsupported device), `PRDGenerationService` generates a placeholder PRD with simulated word-by-word streaming (15ms per word). This enables full UI development without a physical device.

## Performance Considerations

- Each streaming update triggers a SwiftUI view update via `@Observable`
- The `MarkdownView` re-parses `AttributedString` on each update during streaming
- For very long PRDs, consider throttling UI updates to every N tokens
- Generation runs on `@MainActor` to ensure thread-safe UI updates

## Device Compatibility

- Requires iOS 26 or later
- Requires Apple Silicon (A-series or M-series chip)
- Foundation Model size and quality may vary by device capability
- System prompt length should stay concise to avoid token limit issues
