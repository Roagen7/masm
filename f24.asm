

.686
.model flat

extern _ExitProcess@4 : PROC


public f24_main

.data

.code 

f24_main PROC

	mov eax, 012345678H
	xchg al, ah
	bswap eax
	xchg al, ah
	mov bx, 1
	mov cx, 2
	xchg bx, cx

	push dword ptr 0
	call _ExitProcess@4

f24_main ENDP
END