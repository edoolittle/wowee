;; ---------------
;; Local Functions
;; ---------------

;; Create a shortcut to the directory dir, placed in dir ... this may seem useless
;; but is actually very handy for opening a local File Explorer window when viewing
;; a OneDrive folder on the web.  As the local path may be computer dependent,
;; the shortcut name contains the local ComputerName.
create_self_lnk_in_dir(dir) {
    ; Define the shortcut file path (on Desktop in this example)
    shortcutPath := dir "\0" A_ComputerName "-ThisFolder.lnk"

    ; Create the shortcut
    FileCreateShortcut(
        dir,           ; Target path
        shortcutPath,  ; Shortcut file path
        dir            ; "Start in" directory
    )

    MsgBox "Shortcut created at:`n" shortcutPath
}

;; Find the file path of an active File Explorer window.  That directory will be
;; used as "dir" in the create_self_lnk_in_dir() function, and may be used by
;; other functions too.
;; See https://www.autohotkey.com/boards/viewtopic.php?p=387113#p387113
explorerGetPath(hwnd := 0) { 
    Static winTitle := 'ahk_class CabinetWClass'
    hWnd ? explorerHwnd := WinExist(winTitle ' ahk_id ' hwnd)
    : ((!explorerHwnd := WinActive(winTitle)) && explorerHwnd := WinExist(winTitle))
    If explorerHwnd
        For window in ComObject('Shell.Application').Windows
    Try If window && window.hwnd && window.hwnd = explorerHwnd
        Return window.Document.Folder.Self.Path
    Return False
}

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

open_create_expense_claim() {
    root := EnvGet("USERPROFILE") "\OneDrive\Claims"
    result := select_or_create_folder(root)
    if result = "" {
        MsgBox "User cancelled."
    }
    else {
        if result.New {
            FileCopy root "\BlankForms\*.*", result.Path, false
        }
        Run result.Path
    }
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

    Loop Files, pattern, "R" {
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

open_research_project() {
    PN := InputBox("Please enter a project number.", "Project Number")
    if PN.Result = "Cancel"
        open_most_recent(EnvGet("USERPROFILE") "\OneDrive - FNUniv\Administration\ADR\Financial\*Consolidated*.xlsx")
    else
        open_most_recent(EnvGet("USERPROFILE") "\OneDrive - FNUniv\Administration\ADR\Financial\*#" PN.Value "*.xlsx")

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
    send("^!#q") ;; this should be the same as Todoist setting for quick task
}

open_url(url) {
    try {
        Run url  ; Opens in default browser

        ; List of common browser executables in order of likelihood
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

select_or_create_folder(root, title := "Select or Create Folder") {
    ; Ensure root exists
    if !DirExist(root)
        DirCreate(root)
    ; Let user pick a folder
    selected := FileSelect("D8", root, title)
    if selected {
        ; User picked an existing folder
        return { Path: selected, New: false }
    }
    ; User cancelled → ask for new folder name
    name := InputBox("Enter name for new folder:", "Create Folder")
    if name.Result != "OK"
        return ""  ; user cancelled again
    ; Sanitize folder name
    safe := RegExReplace(name.Value, '[\/:*?"<>|]', "_") ; " emacs ahk colorizer broken
    newPath := root "\" safe
    ; Check if folder existed before creation
    existedBefore := DirExist(newPath)
    ; Create if needed
    if !existedBefore
        DirCreate(newPath)
    return { Path: newPath, New: !existedBefore }
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
Capslock & e::open_create_expense_claim()
Capslock & g::open_gnome_terminal()
Capslock & i::open_outlook_inbox()
CapsLock & j::workspace_prev()
CapsLock & k::workspace_next()
CapsLock & l::open_url("https://www.anylist.com/web")
CapsLock & m::open_emacs()
CapsLock & n::open_browser()
CapsLock & p::open_copilot()
CapsLock & q::window_quit()
CapsLock & r::open_research_project()
CapsLock & s::open_outlook_sent()
CapsLock & t::open_todoist()
CapsLock & w::open_copilot_work()
CapsLock & z::open_zotero()

#HotIf WinActive('ahk_class CabinetWClass')
CapsLock & x::create_self_lnk_in_dir(explorerGetPath())
#HotIf
