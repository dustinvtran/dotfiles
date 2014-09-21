#!/bin/bash
# Displays mpv's now playing filename if mpv is running. Most of it was written by frau (see github).

function get_file_playing() {
  video_extensions=( mkv avi mp4 ogm mov flv wmv ts m2ts )
  mpv_pid=$(echo $mpv_pid | sed 's/ //g')
  procs=($(/bin/ls "/proc/$mpv_pid/fd/" | sort -n))
  n=0
  while [[ $n -lt ${#procs[@]} ]] && [[ -z "$file_is_valid" ]]; do
path="$(readlink /proc/$mpv_pid/fd/${procs[n]})"
    if [[ -f "$path" ]]; then
file="$(basename "$path")"
      file_ext="${file##*.}"
      z=0
      while [[ $z -lt ${#video_extensions[@]} ]] && [[ -z "$file_is_valid" ]]; do
if [[ "$file_ext" == "${video_extensions[z]}" ]]; then
file_is_valid=true
break
fi
        ((z++))
      done
if [[ -n "$file_is_valid" ]]; then
echo $file
      fi
fi
    ((n++))
  done
}

mpv_pid=$(ps -C mpv -opid=)
if [[ -z "$mpv_pid" ]]; then
exit 1
fi

case "$1" in
  irc)
    echo "/me is watching $(get_file_playing) -mpv-" ;;
  *)
    #get_file_playing
    echo -n " ⮓ $(get_file_playing) "
esac

# vim:ft=sh
