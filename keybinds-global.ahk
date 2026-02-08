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
        Run('bash -c "emacsclient -c -n -a emacs"', , "Hide")
}

open_browser() {
        Run('cmd /c "start msedge --restore-last-session"', , "Hide")
}


;; ----------------------------
;; Alt Keys Don't Activate Menu
;; ----------------------------

;; see https://www.autohotkey.com/docs/v2/lib/A_MenuMaskKey.htm

~LWin::Send "{Blind}{vkE8}"
~RWin::Send "{Blind}{vkE8}"


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
