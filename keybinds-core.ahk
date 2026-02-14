;; This script provides: keybinds which apply to non-WSL windows

;; -----------
;; M- bindings
;; -----------

!b::backward_word()
!f::forward_word()
!v::scroll_up()
!+w::kill_ring_save()
!w::kill_ring_save()
!bs::backward_kill_word()
!<::beginning_of_buffer()
!>::end_of_buffer()
!.::xref_find_definitions()
!,::xref_go_back()
!?::xref_find_references()

;; -----------
;; C- bindings
;; -----------
^b::backward_char()
^n::next_line()
^p::previous_line()
^f::forward_char()
^e::move_end_of_line()
^+e::move_end_of_line()
^a::move_beginning_of_line()
^+a::move_beginning_of_line()
^d::delete_char()
^v::scroll_down()
^+w::kill_ring_cut() ;; ctrl-w on keyboard sends this when selection active (shift down)
^w::rkill_ring_cut() ;; just in case ... if this causes problems, replace with return
^y::yank()
^/::undo_only()
^k::kill_line()
^+g::quit_g()
^g::quit_g()
^r::isearch("^f", "{Enter}")
^s::isearch("^f", "{Enter}")
^+space::set_mark_command()
^space::set_mark_command()
^z::suspend_frame()

;; -----------
;; C- disables
;; -----------
^+c::return

/*
;; -----------
;; C-x bindings
;; -----------
^x:: {
        hook := InputHook("L1", "{s}{h}{o}{c}{1}{3}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "s") {
                save_buffer()
        }
        if (hook.EndKey == "h") {
                mark_whole_buffer()
        }
        if (hook.EndKey == "o") {
                next_window()
        }
        if (hook.EndKey == "c") {
                kill_frame()
        }
        if (hook.EndKey == "1") {
                maximize_window()
        }
        if (hook.EndKey == "3") {
                split_window_vertically()
        }

        hook := ""
}
*/

;; -----------
;; M-g bindings
;; -----------
!g:: {
        hook := InputHook("L1", "{g}")
        hook.Start()
        hook.Wait()
        if (hook.EndKey == "g") {
                goto_line()
        }
        hook := ""
}
