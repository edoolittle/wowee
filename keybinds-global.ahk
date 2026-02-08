;; ---------------
;; Local Functions
;; ---------------

next_workspace() {
        Send("^#{Right}")
        Click
}

prev_workspace() {
        Send("^#{Left}")
        Click
}

quit_window() {
        Send("!{F4}")
}

open_emacs() {
        Run('cmd.exe /c "C:\Users\jimbo\source\emacs-30.0\start.bat"', , "Hide")
}

open_browser() {
        Run('cmd.exe /c "C:\Program Files\Mozilla Firefox\firefox.exe"', , "Hide")
}


;; ---------------------
;; Hyper Key is CapsLock
;; ---------------------

;; CapsLock off
SetCapsLockState("AlwaysOff")
;; Shift+CapsLock performs CapsLock function
+CapsLock::SetCapsLockState !GetKeyState("CapsLock", "T")

;; -------------------
;; Workspace Switching
;; -------------------

CapsLock & i::next_workspace()
CapsLock & u::prev_workspace()

;; ---------------
;; Window commands
;; ---------------

CapsLock & q::quit_window()

;; --------------------
;; Startup Applications
;; --------------------

CapsLock & m::open_emacs()
CapsLock & n::open_browser()
