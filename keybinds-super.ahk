;; This script provides: keybinds which apply to WSL windows

;; Maybe rethink this, move this to keybinds-apps.ahk

#HotIf WinActive("(GNU Emacs)")
$#i::Send("{F9}i")    ;; s-i   opens gnome-terminal in current directory in emacs
;; $#!m behaving oddly, inserting tabs??
;; $#m reserved for minimze window
;; $!m unmappable -- Windows uses for some gaming panel
$#^m::Send("{F9}^m")  ;; C-s-m removes ^M from emacs buffer
$#u::Send("{F9}u")    ;; s-u   Sudoku in emacs
$#.::Send("{F9}.")    ;; s-.   emoji chooser in emacs
#HotIf
