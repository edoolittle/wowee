#Requires AutoHotkey v2
#Include fundamental.ahk
#Include commands.ahk
/* Key bindings that apply to all windows, including hyper key */
#Include keybinds-global.ahk
/* Key bindings that apply to single specific applications */
#Include keybinds-apps.ahk
/* Key bindings that apply to WSL windows only */
#HotIf WinActive("ahk_class RAIL_WINDOW")
#Include keybinds-super.ahk
#HotIf
/* Key bindings  that apply to non-WSL windows only */
#HotIf !WinActive("ahk_class RAIL_WINDOW")
#Include keybinds-core.ahk
#Include keybinds-init.ahk
#HotIf
