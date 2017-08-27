#!/usr/bin/osascript

tell application "System Events"
  tell process "OpenEmu"
    set frontmost to true
    click menu item "Quick Save" of menu "Controls" of menu bar 1
  end tell
end tell

