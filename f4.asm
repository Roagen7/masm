.686
.model flat

extern _ExitProcess@4 : proc
extern _ReadConsoleInputA@16 : proc
public f4_main


.data
dest byte 7,10,0,0
chs	 dword 0 

.code
f4_main proc
;	call exit

	lea eax, dest
	
	push dword ptr 0
	push dword ptr offset dest
	push dword ptr 4
	push dword ptr offset chs
	push dword ptr 0
	call _ReadConsoleInputA@16

	push 0
	call _ExitProcess@4
f4_main endp
end
