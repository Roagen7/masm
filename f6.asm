; crazy x86 hack

.686
.model flat

extern _ExitProcess@4 : PROC
public f6_main

.code
f6_main PROC
	xor eax, eax 
	mov ebx, 3
	mov ecx, 5

	lea eax, [ebx + ecx * 4] ; eax = ebx + ecx * 4 (poggers hack)
	push 0 
	call _ExitProcess@4
f6_main ENDP
END