#SingleInstance Force

; Load library
#Include komorebic.lib.ahk
; Load configuration
#Include komorebi.generated.ahk

; Send the ALT key whenever changing focus to force focus changes
AltFocusHack("enable")
; Default to cloaking windows when switching workspaces
WindowHidingBehaviour("cloak")
; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")
; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Create named workspaces I-V on monitor 0
EnsureNamedWorkspaces(0, "I II III IV V")
EnsureNamedWorkspaces(1, "I II")
EnsureNamedWorkspaces(2, "A B")
; You can do the same thing for secondary monitors too
; EnsureNamedWorkspaces(1, "A B C D E F")

; Assign layouts to workspaces, possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack
NamedWorkspaceLayout("I", "bsp")
NamedWorkspaceLayout("II", "columns")
NamedWorkspaceLayout("III", "vertical-stack")
NamedWorkspaceLayout("A", "horizontal-stack")
NamedWorkspaceLayout("B", "rows")

; Paddings
NamedWorkspacePadding("I", 5)
NamedWorkspaceContainerPadding("I", 5)
NamedWorkspacePadding("B", 0)
NamedWorkspaceContainerPadding("B", 0)

; You can assign specific apps to named workspaces
; NamedWorkspaceRule("exe", "Firefox.exe", "III")

; Configure the invisible border dimensions
InvisibleBorders(5, 0, 10, 5)

; Uncomment the next lines if you want a visual border around the active window
ActiveWindowBorderWidth(10)
; ActiveWindowBorderOffset(0)
ActiveWindowBorderColour(224, 86, 216, "single")
ActiveWindowBorderColour(256, 165, 66, "stack")
ActiveWindowBorderColour(255, 51, 153, "monocle")
ActiveWindowBorder("enable")

CompleteConfiguration()

; Reload the AHK config file
#^r::ReloadConfiguration()

; Focus windows
#h::Focus("left")
#j::Focus("down")
#k::Focus("up")
#l::Focus("right")
!+[::CycleFocus("previous")
!+]::CycleFocus("next")

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#+Enter::Promote()

; Stack windows
#Left::Stack("left")
#Right::Stack("right")
#Up::Stack("up")
#Down::Stack("down")
#.::Unstack()
#m::CycleStack("previous")
#,::CycleStack("next")

; Resize
#^l::ResizeAxis("horizontal", "increase")
#^h::ResizeAxis("horizontal", "decrease")
#^k::ResizeAxis("vertical", "increase")
#^j::ResizeAxis("vertical", "decrease")

; Manipulate windows
#t::ToggleFloat()
#f::ToggleMonocle()

; Window manager options
#+r::Retile()
#p::TogglePause()

; Layouts
#x::FlipLayout("horizontal")
#y::FlipLayout("vertical")

;Change layout
#a::ChangeLayout("bsp")
#s::ChangeLayout("columns")
#d::ChangeLayout("vertical-stack")

; Workspaces
#1::FocusWorkspace(0)
#2::FocusWorkspace(1)
#3::FocusWorkspace(2)

; Move windows across workspaces
#+1::MoveToWorkspace(0)
#+2::MoveToWorkspace(1)
#+3::MoveToWorkspace(2)

; Close focused window
#+c::Close()

; Focus monitors
#q::FocusMonitor(1)
#w::FocusMonitor(0)
#e::FocusMonitor(2)

; Move window to monitor
#+q::MoveToMonitor(1)
#+w::MoveToMonitor(0)
#+e::MoveToMonitor(2)

; Stop komorebi
#^+q::Stop()