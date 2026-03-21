import Foundation

enum PromptPurpose: String, Codable, CaseIterable, Identifiable {
    case generation
    case suggestion
    case reverse

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .generation: "PRD Generation"
        case .suggestion: "Ingredient Suggestion"
        case .reverse: "Reverse PRD"
        }
    }
}
