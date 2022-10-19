.686
.model flat

extern _ExitProcess@4 : PROC

public f31_main

.code

sum PROC ; int sum(int amount)
	mov ecx, dword ptr [esp + 4] ; ecx = amount
	
	xor eax, eax
lp:
	dec ecx
	add eax, dword ptr [esp + ecx * 4 + 8] 
	cmp ecx, 0
	jne lp

	ret

sum ENDP


f31_main PROC

	push 1
	push 2
	push 3
	push 4
	push 5
	push 6
	push 7
	push 8
	push 9
	push 10

	push 10
	call sum
	add esp, 4

	push 0
	call _ExitProcess@4

f31_main ENDP
END