import Testing
import Foundation
@testable import PRD_Mixer

struct ExportServiceTests {

    // MARK: - Markdown Export

    @Test func markdownFileURL_createsFile() throws {
        let url = ExportService.markdownFileURL(title: "Test PRD", content: "# Hello\n\nWorld")
        #expect(url != nil)
        let content = try String(contentsOf: url!, encoding: .utf8)
        #expect(content == "# Hello\n\nWorld")
        #expect(url!.lastPathComponent == "Test_PRD.md")
    }

    @Test func markdownFileURL_sanitizesFileName() {
        let url = ExportService.markdownFileURL(title: "My App! @#$ Test", content: "content")
        #expect(url != nil)
        #expect(url!.lastPathComponent == "My_App__Test.md")
    }

    @Test func markdownFileURL_emptyTitle_usesFallback() {
        let url = ExportService.markdownFileURL(title: "", content: "content")
        #expect(url != nil)
        #expect(url!.lastPathComponent == "PRD.md")
    }

    // MARK: - Plain Text Export

    @Test func plainTextFileURL_stripsMarkdown() throws {
        let markdown = "# Title\n\n**Bold text** and *italic*"
        let url = ExportService.plainTextFileURL(title: "Test", content: markdown)
        #expect(url != nil)
        let content = try String(contentsOf: url!, encoding: .utf8)
        #expect(!content.contains("#"))
        #expect(!content.contains("**"))
        #expect(!content.contains("*"))
        #expect(url!.pathExtension == "txt")
    }

    // MARK: - Ingredients JSON Export

    @Test func ingredientsJSON_createsValidJSON() throws {
        let ingredients = [
            IngredientData(id: "test1", emoji: "🎮", label: "Gaming", categoryId: "theme", colorHex: "#A29BFE"),
        ]
        let url = ExportService.ingredientsJSON(ingredients)
        #expect(url != nil)

        let data = try Data(contentsOf: url!)
        let export = try JSONDecoder().decode(IngredientExport.self, from: data)
        #expect(export.formatVersion == 1)
        #expect(export.ingredients.count == 1)
        #expect(export.ingredients[0].id == "test1")
    }

    @Test func ingredientsJSON_emptyArray() throws {
        let url = ExportService.ingredientsJSON([])
        #expect(url != nil)

        let data = try Data(contentsOf: url!)
        let export = try JSONDecoder().decode(IngredientExport.self, from: data)
        #expect(export.ingredients.isEmpty)
    }
}
