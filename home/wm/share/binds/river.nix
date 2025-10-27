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

  [[mod] "F10" "toggleKeyboardInput"]

  [[mod] "t" "switchLayoutMonocle"]

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

  [[mod] "F4" "upMonBrightness"]
  [[mod] "F5" "downMonBrightness"]

  [[mod] "F2" "downKeebBrightness"]
  [[mod] "F3" "upKeebBrightness"]

  [[] "XF86AudioMute" "muteAudio"]
  [[] "XF86AudioMicMute" "muteMic"]

  [[mod] "m" "maximize"]
  [[mod shift] "m" "maximize-to-edges"]
  [[mod ctrl] "c" "centerCol"]
  [[mod ctrl] "z" "floatingFocusToggle"]

  [[mod shift ctrl] "h" "addWindowToTab"]
  [[mod shift ctrl] "l" "removeWindowFromTab"]

  [[mod ctrl] "o" "toggleOverview"]
]
