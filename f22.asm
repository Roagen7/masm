; utf16 big endian -> utf16 little endian

.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public f22_main

.data
textBE db 00H, 061H, 00H, 062H, 00H, 063H ; text in utf16 (little endian)
	   db 01H, 05H, 0D8H, 03DH, 0DCH, 08H
textLE db 13 dup(0)

.code 

f22_main PROC

	mov ecx, 0
lp:
	mov al, [textBE + ecx + 1]
	mov byte ptr [textLE + ecx], al
	mov al, [textBE + ecx]
	mov byte ptr [textLE + ecx + 1], al

	add ecx, 2
	cmp ecx, 12
	jne lp

	push dword ptr 0
	push dword ptr offset textLE
	push dword ptr offset textLE
	push dword ptr 0
	call _MessageBoxW@16
	add esp, 16


	push dword ptr 0
	call _ExitProcess@4

f22_main ENDP
END