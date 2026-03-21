import Testing
import Foundation
@testable import PRD_Mixer

struct PromptPurposeTests {

    @Test func allCases_containsThreePurposes() {
        #expect(PromptPurpose.allCases.count == 3)
        #expect(PromptPurpose.allCases.contains(.generation))
        #expect(PromptPurpose.allCases.contains(.suggestion))
        #expect(PromptPurpose.allCases.contains(.reverse))
    }

    @Test func rawValues() {
        #expect(PromptPurpose.generation.rawValue == "generation")
        #expect(PromptPurpose.suggestion.rawValue == "suggestion")
        #expect(PromptPurpose.reverse.rawValue == "reverse")
    }

    @Test func displayNames() {
        #expect(PromptPurpose.generation.displayName == "PRD Generation")
        #expect(PromptPurpose.suggestion.displayName == "Ingredient Suggestion")
        #expect(PromptPurpose.reverse.displayName == "Reverse PRD")
    }

    @Test func id_matchesRawValue() {
        for purpose in PromptPurpose.allCases {
            #expect(purpose.id == purpose.rawValue)
        }
    }

    @Test func codable_roundTrips() throws {
        for purpose in PromptPurpose.allCases {
            let data = try JSONEncoder().encode(purpose)
            let decoded = try JSONDecoder().decode(PromptPurpose.self, from: data)
            #expect(decoded == purpose)
        }
    }
}
