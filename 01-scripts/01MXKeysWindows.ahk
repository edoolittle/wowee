#SingleInstance force
#KeyHistory 100

; Swap Left Win and Left Alt
LWin::LAlt
LAlt::LWin

;; Surface Pen Fix for Swapped Alt and Win
;!F20::Send {F13}
;F13::Send {RWin down}{F20}{RWin up}

;!F19::Send {F14}
;F14::Send {RWin down}{F19}{RWin up}

;!F18::Send {F15}
;F15::Send {RWin down}{F18}{RWin up}

;; F16 == Action Center
;F16::
;    Send {RWin down}
;    Send {a down}
;    Sleep 50
;    Send {a up}
;    Send {RWin up}
;return

; ; F18 == Notification Center
; F18::
;     Send {RWin down}
;     Send {n down}
;     Sleep 50
;     Send {n up}
;     Send {RWin up}
; return

; ; F17 == Task View
; F17::
;     Send {RWin down}
;     Send {Tab down}
;     Sleep 50
;     Send {Tab up}
;     Send {RWin up}
; return

; ; Right Alt + F16 == Move Window to Next Monitor
; >!F16::
;     Send {RWin down}
;     Send {RShift down}
;     Send {Right down}
;     Sleep 50
;     Send {Right up}
;     Send {RShift up}
;     Send {RWin up}
; return

; ; NumpadClear == Equal Sign
; NumpadClear::Send {=}
