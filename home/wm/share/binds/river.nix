settings: let
  inherit
    (settings.keys)
    mod
    shift
    ctrl
    ;
in [
  [[mod] "n" "increaseMasterWindows"]
  [[mod shift] "n" "decreaseMasterWindows"]

  [[mod] "Up" "moveMasterTop"]
  [[mod] "Down" "moveMasterBottom"]
  [[mod] "Right" "moveMasterRight"]
  [[mod] "Left" "moveMasterLeft"]

  [[mod shift ctrl] "k" "resizeFloatUp"]
  [[mod shift ctrl] "j" "resizeFloatDown"]
  [[mod shift ctrl] "l" "resizeFloatRight"]
  [[mod shift ctrl] "h" "resizeFloatLeft"]

  [[mod] "Period" "focusNextOutput"]
  [[mod] "Comma" "focusPrevOutput"]
  [[mod shift] "Period" "moveToNextOutput"]
  [[mod shift] "Comma" "moveToPrevOutput"]

  [[mod] "p" "btmTrayToggle"]

  [[] "XF86MonBrightnessDown" "upMonBrightness"]
  [[] "XF86MonBrightnessUp" "downMonBrightness"]

  [[mod] "F2" "downKeebBrightness"]
  [[mod] "F3" "upKeebBrightness"]

  [[mod] "XF86AudioMute" "muteAudio"]
  [[mod] "XF86AudioMicMute" "muteMic"]
]
