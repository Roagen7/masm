.686
.model flat


extern _ExitProcess@4 : PROC

stp equ 0

public f27_main

.data
;zmienna 
arr db 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0FH, 'z'
sum dw 0

.code 

f27_main PROC
	lea eax, [arr]

lp:
	movzx bx, byte ptr [eax] ; bx = *eax
	cmp bx, stp
	je en

	mov dx, [sum] 
	add dx, bx 
	mov [sum], dx ; sum += bx
	inc eax 
	jmp lp

en:
	push 0
	call _ExitProcess@4

f27_main ENDP
END