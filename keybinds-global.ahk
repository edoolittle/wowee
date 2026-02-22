;; ---------------
;; Local Functions
;; ---------------

open_browser() {
    Run('cmd /c "start msedge --restore-last-session"', , "Hide")
}

open_copilot() {
    Run('cmd /c "start Copilot.lnk"', , "Hide")
}

open_copilot_work() {
    Run('cmd /c "start Copilot-M365.lnk"', , "Hide")
}

open_emacs() {
    Run('bash -c "emacsclient -c -n -a emacs"', , "Hide")
}

open_gnome_terminal() {
    Run('bash -c "gnome-terminal --working-directory=$HOME"', , "Hide")
}

open_outlook_calendar() {
    If !WinExist("Calendar - edoolittle") {
        Run('cmd /c "start Outlook-calendar.lnk"', , "Hide")
    }
    WinWait("Calendar - edoolittle")
    WinActivate("Calendar - edoolittle")
}

open_outlook_contacts() {
    If !WinExist("Contacts - edoolittle") {
        Run('cmd /c "start Outlook-contacts.lnk"', , "Hide")
    }
    WinWait("Contacts - edoolittle")
    WinActivate("Contacts - edoolittle")
}

open_outlook_drafts() {
    If !WinExist("Drafts - edoolittle") {
        Run('cmd /c "start Outlook-drafts.lnk"', , "Hide")
    }
    WinWait("Drafts - edoolittle")
    WinActivate("Drafts - edoolittle")
}

open_outlook_inbox() {
    If !WinExist("Inbox - edoolittle") {
        Run('cmd /c "start Outlook-inbox.lnk"', , "Hide")
    }
    WinWait("Inbox - edoolittle")
    WinActivate("Inbox - edoolittle")
}

open_outlook_sent() {
    If !WinExist("Sent Items - edoolittle") {
        Run('cmd /c "start Outlook-sent.lnk"', , "Hide")
    }
    WinWait("Sent Items - edoolittle")
    WinActivate("Sent Items - edoolittle")
}

open_todoist() {
    If !WinExist("ahk_exe Todoist.exe") {
        Run('cmd /c "start Todoist.lnk"', , "Hide")
    }
    WinWait("ahk_exe Todoist.exe")
    WinActivate("ahk_exe Todoist.exe")
}

open_todoist_quickadd() {
    If !WinExist("ahk_exe Todoist.exe") {
        Run('cmd /c "start Todoist.lnk"', , "Hide")
    }
    WinWait("ahk_exe Todoist.exe")
    ;;WinActivate("ahk_exe Todoist.exe")
    send("^!#q")
}

open_zotero() {
    If !WinExist(" - Zotero") {
        Run('cmd /c "start Zotero.lnk"', , "Hide")
    }
    WinWait(" - Zotero")
    WinActivate(" - Zotero")
}

send_clipboard_to_mac() {
    ;;Clip := A_Clipboard
    RunWait('bash --rcfile=~/.bashrc -i -c "copy-to-mac"')
}

send_clipboard_to_monolith() {
    ;;Clip := A_Clipboard
    RunWait('bash --rcfile=~/.bashrc -i -c "copy-to-mono"')
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

~LAlt::Send "{Blind}{vkE8}"
~RAlt::Send "{Blind}{vkE8}"
~LWin::Send "{Blind}{vkE8}"
~RWin::Send "{Blind}{vkE8}"


;; ------------------
;; Hyper Key Bindings
;; ------------------

;; CapsLock off
SetCapsLockState("AlwaysOff")
;; Shift+CapsLock performs CapsLock function
+CapsLock::SetCapsLockState !GetKeyState("CapsLock", "T")

CapsLock & Down::send_clipboard_to_monolith()
CapsLock & Tab::open_todoist_quickadd()
CapsLock & Up::send_clipboard_to_mac()
Capslock & a::open_outlook_calendar()
CapsLock & c::open_outlook_contacts()
Capslock & d::open_outlook_drafts()
Capslock & g::open_gnome_terminal()
Capslock & i::open_outlook_inbox()
CapsLock & j::workspace_prev()
CapsLock & k::workspace_next()
CapsLock & m::open_emacs()
CapsLock & n::open_browser()
CapsLock & p::open_copilot()
CapsLock & q::window_quit()
CapsLock & s::open_outlook_sent()
CapsLock & t::open_todoist()
CapsLock & w::open_copilot_work()
CapsLock & z::open_zotero()
