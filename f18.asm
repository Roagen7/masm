.686
.model	flat

extern _ExitProcess@4 : proc
extern _MessageBoxA@16 : proc
extern _MessageBoxW@16 : proc

public f18_main

.data
pytanie db "Czy lubisz ako?", 0
caption db "Wazny komunikat"

pytanieW dw 'C', 'z', 'y', ' ', 'l', 'u', 'b', '.', '.', '.', '?', 0
captionW dw 'W', 'a', 0

.code

f18_main proc
lp:
	push dword ptr 24H
	push dword ptr offset captionW
	push dword ptr offset pytanieW
	push dword ptr 0

	call _MessageBoxW@16
	add esp, 16

	cmp eax, dword ptr 6
	jne lp

	push dword ptr 0
	call _ExitProcess@4
f18_main endp
end
