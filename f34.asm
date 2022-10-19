.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __read : PROC

public f34_main

.data
Czw dd 0, 1, 2
Pt dw 3, 4, 5, 6
Sb dw 7, 8, 9, 10, 11, 11, 12, 13
	db 0FFH, 0FFH

Sty	dd 255,256
Lut dw 16, 17, 18, 19
Mar db 8,9,10,11

tekst dw 'ar', 'ch', 'it', 'ek', 'tu', 'ra', 0
.code
f34_main PROC

	mov edi, offset Mar - offset Lut
	mov ebx, Sty[edi]
	add bl, Mar

	sub esp, 64
	mov eax, esp

	push 64
	push eax
	push 0

	call __read
	add esp, 12
	mov bl, [esp + 2]

	push 0
	push offset tekst
	lea eax, dword ptr [tekst + 6]
	push eax
	push 0
	call _MessageBoxA@16

	push 0
	call _ExitProcess@4

f34_main ENDP
END