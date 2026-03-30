;; ---------------
;; Local Functions
;; ---------------

open_browser() {
    Run('cmd /c "start msedge --restore-last-session"', , "Hide")
}

open_copilot() {
    ;; it seems only one Copilot window is open at a time so no need to check
    ;; if !WinExist
    Run('cmd /c "start Copilot.lnk"', , "Hide")
}

open_copilot_work() {
    ;; it seems only one Microsoft 365 Copilot window is open at a time so no
    ;;  need to check if !WinExist
    Run('cmd /c "start Copilot-M365.lnk"', , "Hide")
}

open_emacs() {
    ;; e script will start emacs in daemon mode if not already started
    Run('bash -c "~/bin/e"', , "Hide")
}

open_gnome_terminal() {
    Run('bash -c "gnome-terminal --working-directory=$HOME"', , "Hide")
}

open_gnucash() {
    open_url("https://www.simplii.com")
    If !WinExist("finance.gnucash") {
        Run('cmd /c "start GnuCash.lnk"', , "Hide")
    }
    WinWait("finance.gnucash")
    WinActivate("finance.gnucash")
}

open_most_recent(pattern) {
    latestFile := ""
    latestTime := 0

    Loop Files, pattern {
        t := A_LoopFileTimeModified
        if (t > latestTime) {
            latestTime := t
            latestFile := A_LoopFilePath
        }
    }

    if latestFile != "" {
        Run latestFile
    } else {
        MsgBox "No files found in: " dir
    }
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
        WinWait("ahk_exe Todoist.exe")
        WinActivate("ahk_exe Todoist.exe")
        WinWaitActive("ahk_exe Todoist.exe")
        Sleep(500)
    }
    send("^!#q") ;; this should be the same as Todoist setting
}

open_url(url) {
    try {
        Run url  ; Opens in default browser

        ; List of common browser executables in order of liklihood
        browsers := ["msedge.exe", "firefox.exe", "chrome.exe", "brave.exe", "opera.exe"]

        found := false
        for exe in browsers {
            if WinWait("ahk_exe " exe, , 5) { ; Wait up to 5 seconds for each
                WinActivate  ; Bring browser to front
                WinSetAlwaysOnTop true
                Sleep 500
                WinSetAlwaysOnTop false
                found := true
                break
            }
        }

        if !found {
            MsgBox "No browser window detected.", "Error", 48
        }
    } catch Error as e {
        MsgBox "Failed to open URL:`n" url, "Error", 16
    }
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
;+CapsLock::SetCapsLockState !GetKeyState("CapsLock", "T")

CapsLock::return
CapsLock & Down::send_clipboard_to_monolith()
CapsLock & LShift::{
    MsgBox("You pressed CapsLock + Left Shift!")
    return
}
CapsLock & RShift::SetCapsLockState !GetKeyState("CapsLock", "T")
CapsLock & Tab::open_todoist_quickadd()
CapsLock & Up::send_clipboard_to_mac()
CapsLock & $::open_gnucash()
Capslock & a::open_outlook_calendar()
Capslock & b::open_most_recent(EnvGet("USERPROFILE") "\OneDrive - FNUniv\Finance-Director - 28 - Research and Grad Studies\FY26\*.xlsx")
CapsLock & c::open_outlook_contacts()
Capslock & d::open_outlook_drafts()
Capslock & g::open_gnome_terminal()
Capslock & i::open_outlook_inbox()
CapsLock & j::workspace_prev()
CapsLock & k::workspace_next()
CapsLock & l::open_url("https://www.anylist.com/web")
CapsLock & m::open_emacs()
CapsLock & n::open_browser()
CapsLock & p::open_copilot()
CapsLock & q::window_quit()
CapsLock & s::open_outlook_sent()
CapsLock & t::open_todoist()
CapsLock & w::open_copilot_work()
CapsLock & z::open_zotero()
