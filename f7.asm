; digit to ascii

.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public f7_main

.code 
digit2char PROC ; digit in edx to char in eax
	push edx
	add edx, "0"
	mov eax, edx
	pop edx
	ret
digit2char ENDP

f7_main PROC
	mov edx, 4
	call digit2char

	push dword ptr 0
	call _ExitProcess@4
f7_main ENDP
END