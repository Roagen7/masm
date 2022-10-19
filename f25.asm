.686
.model flat

extern _ExitProcess@4 : PROC


public f25_main

bne equ jne

.data
;zmienna 
arr dw 4567H, 5678H, 6789H
	dw 0A5H
by@  db 0AH
by? db 20 dup(0AH)

ab dw 'ab'
abw dw 'a', 'b'

.code 

f25_main PROC
	
	xor ecx, ecx
	mov eax, offset arr
	lea eax, [arr + ecx]
	
	push 0EFH
lab: ; etykieta

	; mov eax, offset [esp] ; error
lp:	lea eax, [esp + 2] ; === mov eax, esp
	mov eax, esp ; == lea eax, esp
	mov eax, [esp]; != any of these ^^

	push offset lp
	
	xor eax, eax
	mov ax, [arr + 1]
	bne lp

	mov cx, 0CCH
	movzx eax, cx
	mov al, by?
	mov al, [by?]
	mov eax, offset [by?]
	mov eax, dword ptr [by?]
	movzx eax, [by?]


	push dword ptr 0
	call _ExitProcess@4

f25_main ENDP
END