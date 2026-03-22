#!/bin/bash
# Category candidate test runner
# Generates PRDs mixing new category items with existing ingredients
set -e
cd "$(dirname "$0")/.."

CUSTOM="prompts/category_candidates.json"
OUTDIR="outputs/category_test"
mkdir -p "$OUTDIR"

swift build --product prompt-tuner 2>/dev/null

TESTS=(
  # Format: "filename:ids"
  # Mix of existing + new categories
  "01_cat_chat_whisper:appType_chat,platform_ios,theme_cats,ux_brutalist,world_pizza,wild_whisper,mood_chaotic"
  "02_dog_fitness_arcade:appType_fitness,platform_watchos,theme_dogs,mood_hyper,game_rhythm,vibe_retro"
  "03_senior_weather_calm:appType_weather,platform_ios,theme_seniors,world_coffeeshop,mood_calm,ux_minimalist"
  "04_space_ecommerce:appType_ecommerce,platform_visionos,world_space,mood_euphoric,vibe_absurdist,creative_3d"
  "05_medieval_journal:appType_journal,world_castle,mood_dreamy,vibe_cozy,wild_fortune,ux_skeuomorphic"
  "06_tuesday_todo:appType_todo,vibe_zen,wild_tuesday,mood_calm,world_cabin"
  "07_arcade_music:appType_music,vibe_retro,world_park,mood_euphoric,game_rhythm,wild_chiptune"
  "08_kid_photo_island:appType_photo,theme_kids,ux_playful,world_island,wild_plant,mood_hyper"
  "09_cozy_reading:appType_reading,vibe_wholesome,world_cabin,mood_melancholy,ux_glassmorphism"
  "10_haunted_travel:appType_travel,world_haunted,mood_spooky,wild_plottwist,vibe_edgy"
  "11_meme_generator:creative_meme,platform_ios,theme_cats,mood_chaotic,vibe_absurdist,wild_gravity"
  "12_rpg_fitness:game_rpg,appType_fitness,platform_ios,theme_dogs,mood_hyper,ux_colorful"
  "13_puzzle_seniors:game_puzzle,platform_ipados,theme_seniors,mood_calm,world_coffeeshop,ux_playful"
  "14_graphic_design_tool:creative_graphicdesign,platform_macos,ux_minimalist,mood_dreamy,world_tokyo"
  "15_comic_maker_kids:creative_comic,platform_ipados,theme_kids,ux_colorful,mood_euphoric,wild_robot"
  "16_sticker_social:creative_sticker,appType_socialfeed,platform_ios,mood_hangry,vibe_punk"
  "17_idle_clicker_cats:game_idle,theme_cats,platform_ios,mood_calm,world_underwater,vibe_cozy"
  "18_note_taking_fortune:appType_notes,platform_ios,ux_minimalist,wild_fortune,mood_nostalgic,vibe_zen"
  "19_forum_haunted:appType_forum,theme_gaming,world_haunted,mood_spooky,game_br,vibe_edgy"
  "20_calendar_space:appType_calendar,platform_visionos,world_space,mood_hyper,creative_animation,ux_glassmorphism"
  "21_project_tokyo:appType_project,platform_macos,world_tokyo,mood_chaotic,feat_sync,interact_keyboard"
  "22_social_island:appType_socialfeed,platform_ios,world_island,mood_romantic,feat_camera,vibe_wholesome"
  "23_video_edit_retro:creative_video,platform_macos,vibe_retro,wild_chiptune,mood_nostalgic,ux_skeuomorphic"
  "24_music_prod_space:creative_musicprod,platform_macos,world_space,mood_dreamy,vibe_experimental"
  "25_tower_defense_pizza:game_tower,platform_ios,world_pizza,mood_hangry,vibe_absurdist,ux_brutalist"
  "26_roguelike_underwater:game_roguelike,platform_ios,world_underwater,mood_spooky,vibe_punk,theme_cats"
  "27_font_design_castle:creative_font,platform_macos,world_castle,mood_melancholy,ux_glassmorphism"
  "28_illustration_cabin:creative_illustration,platform_ipados,world_cabin,mood_calm,vibe_cozy,ux_playful"
  "29_vn_romantic:game_vn,platform_ios,mood_romantic,world_coffeeshop,theme_creative,ux_glassmorphism"
  "30_ephemeral_chat:appType_chat,wild_ephemeral,mood_chaotic,world_haunted,vibe_experimental,platform_ios"
  "31_lifesim_dogs:game_lifesim,theme_dogs,platform_ios,world_island,mood_euphoric,ux_colorful"
  "32_3d_travel:creative_3d,appType_travel,platform_visionos,world_tokyo,mood_hyper,vibe_experimental"
  "33_timetravel_journal:appType_journal,wild_timetravel,mood_nostalgic,vibe_retro,ux_skeuomorphic"
  "34_robot_weather:appType_weather,wild_robot,world_space,mood_calm,vibe_serious,platform_watchos"
  "35_plant_reading:appType_reading,wild_plant,world_cabin,mood_dreamy,theme_sustainability,vibe_wholesome"
)

echo "Generating ${#TESTS[@]} PRDs with new category candidates..."
echo ""

for test_entry in "${TESTS[@]}"; do
  name="${test_entry%%:*}"
  ids="${test_entry#*:}"
  outfile="$OUTDIR/$name.md"

  if [ -f "$outfile" ]; then
    echo "SKIP $name (already exists)"
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
total_words=$(cat "$OUTDIR"/*.md 2>/dev/null | wc -w | tr -d ' ')
if [ "$count" -gt 0 ]; then
  avg=$((total_words / count))
  echo "$count PRDs generated, avg ${avg}w, total ${total_words}w"
  echo ""
  echo "All outputs in: $OUTDIR/"
fi
