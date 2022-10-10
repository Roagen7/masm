.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public f13_main

.data
message dw 't', 'o', ' '
		dw 'j', 'e', 's', 't', ' '
		dw 'p', 'i', 'e', 's', 0DC31H, 0
caption dw 'Z', 'n', 'a', 'k', 'i', 0

.code

f13_main proc
	
	push dword ptr 0
	push dword ptr offset caption
	push dword ptr offset message
	push dword ptr 0
	call _MessageBoxW@16
	add esp, 16

	push 0
	call _ExitProcess@4

f13_main endp
end