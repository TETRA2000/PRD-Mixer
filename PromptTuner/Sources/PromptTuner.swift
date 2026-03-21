import ArgumentParser

@main
struct PromptTuner: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "prompt-tuner",
        abstract: "Test and iterate on PRD Mixer system prompts and ingredients.",
        subcommands: [
            ListCategories.self,
            ListIngredients.self,
            ShowPrompts.self,
            BuildPrompt.self,
            ValidateIds.self,
            AddCategory.self,
            AddIngredient.self,
            Generate.self,
        ]
    )
}
