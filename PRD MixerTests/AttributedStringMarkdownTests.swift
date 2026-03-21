import Testing
import Foundation
@testable import PRD_Mixer

struct AttributedStringMarkdownTests {

    @Test func inlineMarkdown_parsesWithoutCrash() {
        let result = AttributedString(markdown: "**Bold** and *italic*")
        #expect(!result.characters.isEmpty)
    }

    @Test func fullMarkdown_parsesHeadings() {
        let result = AttributedString(fullMarkdown: "# Heading\n\nParagraph text")
        #expect(!result.characters.isEmpty)
    }

    @Test func plainText_passesThrough() {
        let result = AttributedString(markdown: "Just plain text")
        let text = String(result.characters)
        #expect(text == "Just plain text")
    }

    @Test func emptyString_returnsEmpty() {
        let result = AttributedString(markdown: "")
        #expect(result.characters.isEmpty)
    }

    @Test func fullMarkdown_emptyString() {
        let result = AttributedString(fullMarkdown: "")
        #expect(result.characters.isEmpty)
    }
}
