#!/usr/bin/env bash

##############
# Directives #
##############

# Some items are defined elsewhere
# shellcheck disable=SC2154

#############
# Functions #
#############

patina_calibrate_terminal_draw_columns() {
  for (( i=1; i <= width; ++i )) ; do
    printf "#"
  done
  printf "\\n"
}

patina_calibrate_terminal_draw_rows() {
  printf "%b" "${patina_minor_color}"
  for (( j=2; j <= height; ++j )) ; do
    patina_calibrate_terminal_draw_columns
  done
  printf "%b" "${color_reset}"
}

patina_calibrate_terminal_window() {
  # Define terminal dimensions
  local width="$1"
  local height="$2"

  # Create regular expression
  local number='^[0-9]+$'

  # Failure: One or both of the required arguments are null or not numbers
  if ! [[ $width =~ $number ]] || ! [[ $height =~ $number ]] ; then
    patina_throw_exception 'PE0001'

  # Failure: One or both of the arguments are '0'
  elif [[ $width = "0" ]] || [[ $height = "0" ]] ; then
    patina_throw_exception 'PE0003'

  # Failure: Arguments are out-of-range
  elif [[ $width -lt 80 || $width -gt 300 ]] || [[ $height -lt 24 || $height -gt 300 ]] ; then
    patina_throw_exception 'PE0003'

  # Success: Both arguments exist and are numeric
  elif [[ $width =~ $number && $width -gt 0 ]] && [[ $height =~ $number && $height -gt 0 ]] ; then
    reset
    patina_calibrate_terminal_draw_rows

  # Failure: Catch any other error condition here
  else
    patina_throw_exception 'PE0000'
  fi

  # Cleanup local variables after use
  unset -v width height number
}

###########
# Aliases #
###########

alias 'p-calibrate'='patina_calibrate_terminal_window'

# End of File.