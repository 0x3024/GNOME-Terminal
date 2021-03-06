#!/usr/bin/env bash

#   Name:       3024 night
#   Author:     Jan T. Sott (http://github.com/idleberg)

#   3024 color scheme template by Jan T. Sott (https://github.com/idleberg)
#   Built with a modified version of Base16 Builder by Chris Kempson (https://github.com/chriskempson)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 3024"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-3024"
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#090300:#db2d20:#01a252:#fded02:#01a0e4:#a16a94:#b5e4f4:#a5a2a2:#5c5855:#e8bbd0:#3a3432:#4a4543:#807d7c:#d6d5d4:#cdab53:#f7f7f7"
gset string background_color "#090300"
gset string foreground_color "#a5a2a2"
gset string bold_color "#a5a2a2"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
