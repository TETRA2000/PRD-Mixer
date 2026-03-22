#!/bin/bash
# A/B test runner for PRD generation prompts
# Usage: ./scripts/run_ab_test.sh

set -e
cd "$(dirname "$0")/.."

TESTS=(
  "t1_absurd_classic:appType_todo,platform_ios,theme_cats,ux_brutalist,vibe_absurdist,scale_weekend"
  "t2_contradictory_enterprise:appType_ecommerce,platform_visionos,theme_seniors,ux_skeuomorphic,feat_voice,interact_gesture,vibe_serious,scale_enterprise"
  "t3_feature_overload:appType_weather,platform_ios,feat_push,feat_offline,feat_widgets,feat_camera,feat_social,feat_analytics,interact_haptic,vibe_edgy"
  "t4_minimal_input:appType_journal,vibe_cozy"
  "t5_maximum_absurdity:appType_fitness,platform_watchos,theme_dogs,ux_glassmorphism,feat_camera,interact_drag,vibe_joke,scale_solo"
  "t6_wholesome_weekend:appType_reading,platform_ios,theme_kids,ux_playful,feat_a11y,interact_tap,vibe_wholesome,scale_mvp"
  "t7_retro_hipster:appType_music,platform_macos,theme_creative,ux_colorful,feat_shortcuts,interact_keyboard,vibe_retro,scale_team"
  "t8_zen_contradiction:appType_chat,platform_ios,theme_business,ux_minimalist,feat_auth,interact_convo,vibe_zen,scale_production"
)

VARIANTS=("v4_baseline:prompts/generation_v4.txt" "v5a:prompts/generation_v5a.txt" "v5b:prompts/generation_v5b.txt" "v5c:prompts/generation_v5c.txt")

swift build --product prompt-tuner 2>/dev/null

for variant_entry in "${VARIANTS[@]}"; do
  variant="${variant_entry%%:*}"
  prompt="${variant_entry#*:}"
  echo "=== Variant: $variant ==="
  mkdir -p "outputs/$variant"

  for test_entry in "${TESTS[@]}"; do
    name="${test_entry%%:*}"
    ids="${test_entry#*:}"
    outfile="outputs/$variant/$name.md"

    if [ -f "$outfile" ]; then
      echo "  SKIP $name (already exists)"
      continue
    fi

    echo -n "  $name ... "
    if swift run prompt-tuner generate --ids "$ids" --system-prompt-file "$prompt" --output "$outfile" 2>/dev/null; then
      words=$(wc -w < "$outfile" | tr -d ' ')
      echo "OK (${words}w)"
    else
      echo "FAILED"
    fi
  done
done

echo ""
echo "=== Summary ==="
for variant_entry in "${VARIANTS[@]}"; do
  variant="${variant_entry%%:*}"
  count=$(ls outputs/$variant/*.md 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -gt 0 ]; then
    avg=$(cat outputs/$variant/*.md | wc -w | tr -d ' ')
    avg=$((avg / count))
    echo "$variant: $count files, avg ${avg}w"
  fi
done
