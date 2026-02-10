;; ---------------
;; Local Functions
;; ---------------

open_browser() {
    Run('cmd /c "start msedge --restore-last-session"', , "Hide")
}

open_emacs() {
    Run('bash -c "emacsclient -c -n -a emacs"', , "Hide")
}

open_outlook_calendar() {
    If !WinExist("Calendar - edoolittle") {
        Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE /select outlook:calendar"
    }
    WinWait("Calendar - edoolittle")
    WinActivate("Calendar - edoolittle")
}

open_outlook_contacts() {
    If !WinExist("Contacts - edoolittle") {
        Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE /select outlook:contacts"
    }
    WinWait("Contacts - edoolittle")
    WinActivate("Contacts - edoolittle")
}

open_outlook_drafts() {
    If !WinExist("Drafts - edoolittle") {
        Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE /select outlook:drafts"
    }
    WinWait("Drafts - edoolittle")
    WinActivate("Drafts - edoolittle")
}

open_outlook_inbox() {
    If !WinExist("Inbox - edoolittle") {
        Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE /select outlook:inbox"
    }
    WinWait("Inbox - edoolittle")
    WinActivate("Inbox - edoolittle")
}

open_outlook_sent() {
    If !WinExist("Sent Items - edoolittle") {
        Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE /select outlook:sent%20items"
    }
    WinWait("Sent Items - edoolittle")
    WinActivate("Sent Items - edoolittle")
}

window_quit() {
    Send("!{F4}")
}

workspace_next() {
    Send("^#{Right}")
    Click
}

workspace_prev() {
    Send("^#{Left}")
    Click
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

CapsLock & j::workspace_next()
CapsLock & k::workspace_prev()

;; ---------------
;; Window commands
;; ---------------

CapsLock & q::window_quit()

;; ------------------
;; Start Applications
;; ------------------

Capslock & a::open_outlook_calendar()
CapsLock & c::open_outlook_contacts()
Capslock & d::open_outlook_drafts()
Capslock & i::open_outlook_inbox()
CapsLock & m::open_emacs()
CapsLock & n::open_browser()
CapsLock & s::open_outlook_sent()
