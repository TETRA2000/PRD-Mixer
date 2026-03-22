#!/bin/bash
# Category candidate test — Round 2 (Hobby, Companion, Pop Culture, Transportation)
set -e
cd "$(dirname "$0")/.."

CUSTOM="category_candidates.json"
OUTDIR="outputs/category_test_r2"
mkdir -p "$OUTDIR"

swift build --product prompt-tuner 2>/dev/null

TESTS=(
  # Hobby combos
  "01_origami_todo:appType_todo,platform_ios,hobby_origami,ux_minimalist,vibe_zen"
  "02_karaoke_chat:appType_chat,platform_ios,hobby_karaoke,ux_colorful,vibe_absurdist,theme_dogs"
  "03_pottery_journal:appType_journal,hobby_pottery,world_cabin,vibe_cozy,ux_skeuomorphic"
  "04_stargazing_weather:appType_weather,platform_ios,hobby_stargazing,world_space,vibe_experimental"
  # Companion combos
  "05_dragon_fitness:appType_fitness,platform_watchos,companion_dragon,ux_playful,vibe_joke"
  "06_ghost_reading:appType_reading,companion_ghost,world_haunted,vibe_edgy,theme_cats"
  "07_cactus_notes:appType_notes,platform_ios,companion_cactus,ux_brutalist,vibe_punk"
  "08_owl_calendar:appType_calendar,companion_owl,ux_minimalist,vibe_serious,theme_business"
  "09_parrot_ecommerce:appType_ecommerce,platform_ios,companion_parrot,world_island,vibe_absurdist"
  # Pop Culture combos
  "10_lofi_music:appType_music,platform_ios,pop_lofi,ux_glassmorphism,vibe_cozy"
  "11_cyberpunk_project:appType_project,platform_macos,pop_cyberpunk,ux_darkmode,theme_business"
  "12_cottagecore_photo:appType_photo,platform_ios,pop_cottagecore,ux_playful,vibe_wholesome,theme_cats"
  "13_anime_forum:appType_forum,platform_ios,pop_anime,ux_colorful,theme_gaming"
  "14_steampunk_travel:appType_travel,pop_steampunk,world_castle,vibe_retro,feat_location"
  # Transportation combos
  "15_rocket_todo:appType_todo,transport_rocket,world_space,vibe_absurdist,ux_brutalist"
  "16_bicycle_fitness:appType_fitness,platform_ios,transport_bicycle,hobby_birdwatching,vibe_wholesome"
  "17_carpet_reading:appType_reading,transport_carpet,pop_anime,companion_fairy,vibe_cozy"
  "18_submarine_photo:appType_photo,platform_ios,transport_submarine,world_underwater,vibe_experimental"
  "19_train_journal:appType_journal,transport_train,pop_steampunk,companion_owl,ux_skeuomorphic"
  # Wild mixes (all 4 new categories together)
  "20_mega_mix_1:appType_chat,hobby_karaoke,companion_parrot,pop_vaporwave,transport_balloon,ux_colorful"
  "21_mega_mix_2:game_rpg,hobby_boardgames,companion_dragon,pop_pixelart,transport_carpet,vibe_joke"
  "22_mega_mix_3:creative_meme,hobby_skateboarding,companion_ai,pop_90scartoon,transport_skateboard"
  "23_mega_mix_4:appType_socialfeed,hobby_gardening,companion_cactus,pop_cottagecore,transport_bicycle,vibe_wholesome"
  "24_mega_mix_5:game_roguelike,hobby_fishing,companion_ghost,pop_cyberpunk,transport_submarine,world_underwater"
  "25_mega_mix_6:appType_weather,hobby_stargazing,companion_alien,pop_synthwave,transport_rocket,world_space"
)

echo "Generating ${#TESTS[@]} PRDs (Round 2)..."
echo ""

for test_entry in "${TESTS[@]}"; do
  name="${test_entry%%:*}"
  ids="${test_entry#*:}"
  outfile="$OUTDIR/$name.md"

  if [ -f "$outfile" ]; then
    echo "SKIP $name (exists)"
    continue
  fi

  echo -n "$name ... "
  if swift run prompt-tuner generate --ids "$ids" --custom-file "$CUSTOM" --output "$outfile" 2>/dev/null; then
    words=$(wc -w < "$outfile" | tr -d ' ')
    title=$(head -1 "$outfile" | sed 's/^#\+ //')
    echo "OK (${words}w) — $title"
  else
    echo "FAILED"
  fi
done

echo ""
echo "=== Summary ==="
count=$(ls "$OUTDIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$count" -gt 0 ]; then
  total_words=$(cat "$OUTDIR"/*.md 2>/dev/null | wc -w | tr -d ' ')
  avg=$((total_words / count))
  echo "$count PRDs generated, avg ${avg}w"
fi
