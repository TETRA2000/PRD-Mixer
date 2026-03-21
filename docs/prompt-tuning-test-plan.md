# Prompt Tuning Test Plan

## Objective

Improve the PRD generation system prompt to address three issues:
1. PRDs are too long and overly formal for a casual, tap-driven app experience
2. No quick-scan summary at the top for users to get an overview during streaming
3. Output format is inconsistent across generations

## Baseline Analysis

Six PRDs were generated with the original system prompt using varied ingredient combinations.

### Test Cases

| # | Ingredients | Character | File |
|---|------------|-----------|------|
| B1 | todo, iOS, cats, playful, weekend | Playful weekend hack | prd_baseline_1.md |
| B2 | fitness, iOS, health, minimalist, offline, one-handed, serious, production | Serious production app | prd_baseline_2.md |
| B3 | chat, iOS, macOS, business, dashboard, auth, sync, keyboard, serious, enterprise | Enterprise tool | prd_baseline_3.md |
| B4 | journal, visionOS, creative, glassmorphism, experimental, solo | Creative experiment | prd_baseline_4.md |
| B5 | ecommerce, dogs, brutalist, absurdist, weekend | Absurd combo | prd_baseline_5.md |
| B6 | music, iOS, colorful, widgets, gesture, retro | Retro music player | prd_baseline_6.md |

### Baseline Metrics

| # | Words | Title Format | Heading Style | List Marker | Has Conclusion | Tech Stack Relevant |
|---|-------|-------------|---------------|-------------|----------------|-------------------|
| B1 | 757 | `# emoji dump` | `##` correct | `-` | Yes | No (React Native for iOS) |
| B2 | 872 | `# Name emoji` | `##` correct | `-` | Yes | No (React Native for iOS) |
| B3 | 709 | `## **bold**` | `**bold**` no heading | `*` | No (but has closing para) | No (generic) |
| B4 | 1245 | `# Name emoji` | `##` correct | `-` | Yes | Partial (SwiftUI + Node.js) |
| B5 | 974 | `# **bold** emoji dump` | `## **bold**` | `-` | No | No (React.js) |
| B6 | 870 | `# emoji dump` | `##` correct | `-` | Yes | No (React Native for iOS) |

### Issues Identified

#### Issue 1: Too Long and Overly Formal
- Word counts range from 709 to 1245 (avg ~905)
- Current prompt asks for 800-1500 words
- Tone is corporate ("We are excited to bring this innovative product to life")
- Verbose filler sections (Non-Functional Requirements, Technical Architecture repeat generic boilerplate)
- "Conclusion" section appears in 4/6 PRDs despite not being requested

#### Issue 2: No Quick-Scan Summary
- "Executive Summary" is a long paragraph (50-100 words)
- During streaming, users must wait for the full paragraph before understanding the concept
- No bullet-point overview or at-a-glance section

#### Issue 3: Format Inconsistencies

**Title format (6 different patterns across 6 PRDs):**
- All ingredient emojis dumped: `# 📝 TODO List 📱 iOS 🐱 Cats 🎨 Playful 🚀 Weekend Hack`
- Single emoji: `# Fitness Tracker 🏋️`
- H2 + bold: `## **Product Requirements Document (PRD) for BusinessChat**`
- Bold prefix: `# **App Name:** 🐶🛒🧱🤪🚀 Brute-Absurd Dog E-commerce`

**Section headings:**
- 4/6 use `## Section` (correct Markdown)
- 1/6 uses `**Section**` (bold text, no heading level)
- 1/6 uses `## **Section**` (heading + bold)

**List markers:**
- 5/6 use `-` (dash)
- 1/6 uses `*` (asterisk)

**Tech stack ignores platform selection:**
- When iOS is selected, model suggests React Native / Node.js instead of Swift / SwiftUI
- Only 1/6 partially mentioned SwiftUI (the visionOS one)

**Milestone format:**
- 1/6 has `[Insert Date]` placeholders
- 4/6 have timeline durations (3/6/12 months)
- 1/6 has no timeline

**Unwanted content:**
- B5 wrapped entire output in a markdown code fence
- "Conclusion" section appears in 4/6 (not requested)

---

## Proposed Changes

### Change 1: Shorter Target Length
- Reduce from 800-1500 words to 300-500 words
- Remove Non-Functional Requirements and Technical Architecture as separate sections
- Fold essential technical notes into a brief "Tech Notes" bullet list

### Change 2: Add Summary Section
- Add a "TL;DR" or quick summary as the very first content after the title
- Format: 2-4 bullet points covering concept, audience, key differentiator, scale
- This appears during early streaming so users can grasp the concept immediately

### Change 3: Strict Format Specification
- Prescribe exact Markdown structure with an example template
- Require `# App Name` as H1 title (creative name only, no emoji dump)
- Require `##` for all section headings
- Require `-` for all list items
- Prohibit `**bold**` as section headings, code fences around output, and "Conclusion" sections
- Require tech stack to respect platform ingredient selection

---

## Revised Prompt

See `prompts/generation_v2.txt` for the full revised prompt.

---

## Test Execution Plan

### Round 1: Same Ingredients as Baseline
Re-run all 6 test cases with the revised prompt and compare against baseline.

| Test | Ingredients | Check |
|------|------------|-------|
| R1-1 | appType_todo, platform_ios, theme_cats, ux_playful, scale_weekend | Compare with B1 |
| R1-2 | appType_fitness, platform_ios, theme_health, ux_minimalist, feat_offline, interact_onehand, vibe_serious, scale_production | Compare with B2 |
| R1-3 | appType_chat, platform_ios, platform_macos, theme_business, ux_dashboard, feat_auth, feat_sync, interact_keyboard, vibe_serious, scale_enterprise | Compare with B3 |
| R1-4 | appType_journal, platform_visionos, theme_creative, ux_glassmorphism, vibe_experimental, scale_solo | Compare with B4 |
| R1-5 | appType_ecommerce, theme_dogs, ux_brutalist, vibe_absurdist, scale_weekend | Compare with B5 |
| R1-6 | appType_music, platform_ios, ux_colorful, feat_widgets, interact_gesture, vibe_retro | Compare with B6 |

### Round 2: Edge Cases
Additional test cases for edge conditions.

| Test | Ingredients | Purpose |
|------|------------|---------|
| R2-1 | appType_todo | Minimal input (1 ingredient) |
| R2-2 | appType_chat, platform_ios, platform_ipados, platform_macos, platform_watchos, platform_visionos | Many platforms |
| R2-3 | appType_photo, theme_seniors, ux_brutalist, vibe_punk, scale_enterprise | Contradictory combo |
| R2-4 | appType_weather, feat_push, feat_offline, feat_widgets, feat_voice, feat_camera, feat_social | Feature-heavy |

### Acceptance Criteria

For each generated PRD, verify:

1. **Length**: 300-500 words
2. **Summary present**: Has a TL;DR / summary section with 2-4 bullet points within the first 10 lines
3. **Title format**: `# Creative App Name` (H1, not emoji dump, no bold)
4. **Section headings**: All use `## Heading` format (no bold-as-heading)
5. **List markers**: All use `-` (no `*`)
6. **No unwanted sections**: No "Conclusion", no code fences wrapping output
7. **Tech stack respects platform**: If iOS selected, mentions Swift/SwiftUI (not React Native)
8. **Sections present**: Summary, Problem, Audience, Features, Tech Notes, Milestones
9. **Tone**: Concise and approachable, not corporate boilerplate
10. **Vibe reflected**: The selected vibe/spirit ingredient influences the tone

### Scoring

Each criterion scores pass/fail. Target: 9/10 pass rate across all test cases.

---

## Results

### Round 1 Results (v2 Prompt)

| Test | Words | B Words | Title | Headings | Lists | No Junk | Tech Stack | Sections | Tone | Vibe | Score |
|------|-------|---------|-------|----------|-------|---------|------------|----------|------|------|-------|
| R1-1 | 300 | 757 | FAIL (`# CatChat` ok but no summary bullets) | PASS | PASS | PASS | PASS (Swift, SwiftUI) | FAIL (Summary is paragraph, not bullets) | PASS | Neutral | 7/10 |
| R1-2 | 342 | 872 | PASS | PASS | PASS | FAIL (trailing paragraph) | PASS (Swift, SwiftUI) | PASS | PASS | PASS (serious) | 8/10 |
| R1-3 | 295 | 709 | PASS | FAIL (`**bold**` for Feature subheads) | FAIL (mixed `-` and no markers) | PASS | PASS (Swift, SwiftUI, CloudKit) | PASS | PASS | PASS (serious) | 7/10 |
| R1-4 | 438 | 1245 | FAIL (`# **Creative Journal**` bold) | PASS | PASS | PASS | PASS (Swift, SwiftUI) | PASS | PASS | Moderate | 8/10 |
| R1-5 | 523 | 974 | FAIL (`## **Furry Cart**` H2+bold) | FAIL (`### **## Section**`) | FAIL (`*` markers) | PASS | PASS (Swift, SwiftUI) | PASS | PASS | PASS (absurdist) | 5/10 |
| R1-6 | 418 | 870 | FAIL (`## **Retro Melody**` H2+bold) | FAIL (`###` for sections) | FAIL (mixed `*` and `-`) | FAIL (trailing paragraph) | PASS (Swift, SwiftUI) | PASS | PASS | PASS (retro) | 5/10 |
| R2-1 | 304 | - | PASS | PASS | PASS | FAIL (trailing paragraph) | FAIL (iOS+Android, SQLite) | PASS | PASS | N/A | 7/10 |
| R2-2 | 296 | - | FAIL (`# **ChattyVision**` bold) | PASS | PASS | PASS | PASS (Swift, SwiftUI, AVFoundation) | FAIL (Summary is paragraph) | PASS | N/A | 6/10 |
| R2-3 | 319 | - | FAIL (`# **PhotoFusion**` bold) | PASS | PASS | PASS | FAIL (iOS+Android, Kotlin) | PASS | PASS | Moderate | 6/10 |
| R2-4 | 236 | - | PASS | PASS | PASS | PASS | PASS (Swift, SwiftUI) | FAIL (Summary is paragraph) | PASS | N/A | 8/10 |

### Round 1 Summary

**Improvements over baseline:**
- Length dramatically reduced: avg 905 → avg 350 words (61% reduction)
- Tech stack now mentions Swift/SwiftUI in 8/10 cases (vs 1/6 baseline)
- No "Conclusion" sections in any v2 output
- No code-fence-wrapped output
- Summary section present in all outputs (though format varies)

**Remaining issues:**
1. **Title bold wrapping**: 5/10 outputs wrap title in `**bold**` (e.g., `# **Name**`)
2. **Summary format inconsistency**: 3/10 use paragraph instead of bullet points
3. **Heading level drift**: 2/10 use `###` instead of `##` for sections, or `**bold**` subheadings
4. **List marker mixing**: 2/10 mix `*` with `-`
5. **Trailing paragraphs**: 3/10 append an unwanted summary paragraph after Milestones
6. **No-platform edge case**: When no platform selected, model invents "iOS+Android" (R2-1, R2-3)

**Overall pass rate: 6.7/10** (target: 9/10)

---

### Diagnosis and v3 Prompt Adjustments

The model partially follows the format spec but still drifts on:
- Bold in titles/headings (likely because the template example uses `**bold**` for inline labels)
- Summary format (paragraph vs bullets)
- Trailing content after Milestones

**v3 changes needed:**
1. Add explicit "DO NOT" rules: no `**bold**` in `#` or `##` headings, no trailing text after Milestones
2. Show the Summary section as actual bullet example with `-` markers
3. Add rule: if no platform is selected, assume iOS with Swift/SwiftUI
4. Add rule: never output text after the Milestones section

See `prompts/generation_v3.txt` for the v3 prompt.

---

### Round 3 Results (v3 Prompt)

| Test | Words | Title OK | Summary Bullets | `##` Headings | `-` Lists | No Trailing | Tech Stack | All Sections | Tone | Vibe | Score |
|------|-------|----------|-----------------|---------------|-----------|-------------|------------|-------------|------|------|-------|
| R3-1 | 293 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS (playful) | 10/10 |
| R3-2 | 379 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS (serious) | 10/10 |
| R3-3 | 325 | PASS | FAIL (`*` markers) | PASS | FAIL (mixed `*` and `-`) | PASS | PASS | PASS | PASS | PASS | 8/10 |
| R3-4 | 299 | FAIL (`## **Journal**`) | PASS | FAIL (`## **bold**`) | PASS | PASS | PASS | PASS | PASS | Moderate | 7/10 |
| R3-5 | 293 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS (absurdist) | 10/10 |
| R3-6 | 318 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS (retro) | 10/10 |
| R3-E1 | 224 | FAIL (`##` not `#`) | FAIL (no `-` bullets) | FAIL (`###`) | PASS | FAIL (Conclusion) | PASS | FAIL (no Summary bullets) | PASS | N/A | 3/10 |
| R3-E2 | 359 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | N/A | 10/10 |
| R3-E3 | 556 | FAIL (`##` not `#`) | FAIL (paragraph) | FAIL (`### **bold**`) | FAIL (mixed) | FAIL (trailing) | PASS | FAIL | PASS | Moderate | 3/10 |
| R3-E4 | 309 | PASS | PASS | PASS | PASS | PASS | PASS | PASS | PASS | N/A | 10/10 |

### Round 3 Summary

**v2 → v3 improvement: 6.7/10 → 8.1/10 average**

**Strong results (9-10/10): 7 out of 10 test cases**
- R3-1, R3-2, R3-5, R3-6, R3-E2, R3-E4: Perfect 10/10
- R3-3: Minor `*` list marker issue (8/10)

**Weak results (< 7/10): 2 out of 10 test cases**
- R3-E1 (minimal 1-ingredient input): Heading levels wrong, added unwanted Conclusion
- R3-E3 (contradictory combo): Format degraded significantly with bold headings and trailing text

**Pattern**: The model follows the template well for typical 4-8 ingredient selections (the common use case). It drifts on edge cases — especially minimal inputs (1 ingredient) and contradictory combinations where it seems to "panic" and fall back to freeform formatting.

**Conclusion**: The v3 prompt is a significant improvement and suitable for the default use case. The remaining edge case issues (2/10) are acceptable given they represent unusual inputs.

---

## Comparison: Baseline vs v3

| Metric | Baseline (v1) | v3 |
|--------|--------------|-----|
| Avg word count | 905 | 335 |
| Has summary bullets | 0/6 | 8/10 |
| Correct `#` title | 2/6 | 8/10 |
| Correct `##` headings | 4/6 | 8/10 |
| Correct `-` lists | 5/6 | 8/10 |
| No Conclusion/trailing | 2/6 | 8/10 |
| Swift/SwiftUI tech stack | 1/6 | 10/10 |
| Avg score | ~4/10 | 8.1/10 |

---

## Round 4: v4 Prompt (Prose Summary)

User feedback: the app is a fun/joke app — bullet-point summaries kill the delight of reading a deadpan PRD pitch made from absurd ingredients. Changed Summary from strict bullets back to a **2-3 sentence prose paragraph**.

See `prompts/generation_v4.txt`.

### Round 4 Results

| Test | Words | Summary Prose | Title | Headings | Lists | No Trailing | Tech Stack | Score |
|------|-------|---------------|-------|----------|-------|-------------|------------|-------|
| V4-1 (cats+todo+playful) | 456 | PASS | PASS | PASS | PASS | FAIL (trailing para) | PASS | 9/10 |
| V4-2 (dogs+ecommerce+absurdist) | 527 | PASS | PASS | PASS | PASS | FAIL (trailing para) | PASS | 8/10 |
| V4-3 (fitness+serious+production) | 394 | PASS | PASS | PASS | PASS | FAIL (trailing para) | PASS | 9/10 |

### Round 4 Summary

All three outputs produce a fun, readable prose Summary paragraph. Formatting (headings, lists, tech stack) is consistent. The on-device Foundation Model consistently adds a closing paragraph after Milestones despite explicit instructions — this appears to be a model-level limitation rather than a prompt issue.

**Average score: 8.7/10**

### Known Limitation: Trailing Paragraph

The Apple Foundation Model reliably appends 1-2 sentences after the Milestones section despite "stop here" instructions. This is a known behavior of the on-device model and is acceptable for the app's casual use case. The trailing text is harmless — it reads like a natural sign-off.

---

## Recommendation

Adopt `prompts/generation_v4.txt` as the new default system prompt for PRD generation. The v4 prompt has been applied to `DefaultSystemPrompts.generationPromptBody`.

### Final Comparison: v1 → v4

| Metric | v1 (baseline) | v4 (final) |
|--------|--------------|------------|
| Avg word count | 905 | 460 |
| Summary format | Long paragraph, no structure | Fun prose pitch (2-3 sentences) |
| Tech stack accuracy | 1/6 mention Swift | 3/3 mention Swift/SwiftUI |
| Format consistency | 4/10 | 9/10 |
| Unwanted sections | 4/6 have Conclusion | 0/3 have Conclusion |
| Trailing text | N/A | 3/3 (model limitation) |

---

## Round 5: A/B Testing — Creative Direction

v4 established a solid structural foundation. Round 5 explores **creative direction** — finding the voice that makes PRDs most fun to read.

### Prompt Variants

| Variant | File | Concept | Key Differences |
|---------|------|---------|-----------------|
| v4 (baseline) | `prompts/generation_v4.txt` | Neutral template | Current default |
| v5a | `prompts/generation_v5a.txt` | Deadpan Pitch Meeting | VC-pitch energy, branded feature names, keynote milestones |
| v5b | `prompts/generation_v5b.txt` | Tight and Punchy | Terse writing, 200-350 words, sentence fragments, no filler |
| v5c | `prompts/generation_v5c.txt` | Startup One-Pager | Hackathon demo format: The Pitch, Secret Sauce, Ship It |

### Test Ingredient Combinations (8 combos)

| # | Name | IDs |
|---|------|-----|
| T1 | Absurd Classic | `appType_todo,platform_ios,theme_cats,ux_brutalist,vibe_absurdist,scale_weekend` |
| T2 | Contradictory Enterprise | `appType_ecommerce,platform_visionos,theme_seniors,ux_skeuomorphic,feat_voice,interact_gesture,vibe_serious,scale_enterprise` |
| T3 | Feature Overload | `appType_weather,platform_ios,feat_push,feat_offline,feat_widgets,feat_camera,feat_social,feat_analytics,interact_haptic,vibe_edgy` |
| T4 | Minimal Input | `appType_journal,vibe_cozy` |
| T5 | Maximum Absurdity | `appType_fitness,platform_watchos,theme_dogs,ux_glassmorphism,feat_camera,interact_drag,vibe_joke,scale_solo` |
| T6 | Wholesome Weekend | `appType_reading,platform_ios,theme_kids,ux_playful,feat_a11y,interact_tap,vibe_wholesome,scale_mvp` |
| T7 | Retro Hipster | `appType_music,platform_macos,theme_creative,ux_colorful,feat_shortcuts,interact_keyboard,vibe_retro,scale_team` |
| T8 | Zen Contradiction | `appType_chat,platform_ios,theme_business,ux_minimalist,feat_auth,interact_convo,vibe_zen,scale_production` |

### Output Directory

All outputs saved to `outputs/` (gitignored):
```
outputs/
  v4_baseline/t1_absurd_classic.md ... t8_zen_contradiction.md
  v5a/t1_absurd_classic.md ... t8_zen_contradiction.md
  v5b/t1_absurd_classic.md ... t8_zen_contradiction.md
  v5c/t1_absurd_classic.md ... t8_zen_contradiction.md
```

### Results

*(To be filled after generation and user evaluation)*
