.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC 

public f32_main

.code

kwadrat PROC ; int sum(int a, int b)     return a * a + b
	
	mov eax, [esp + 4]
	mov ebx, [esp + 8]

	xor edx, edx
	mul eax ; a * a
	add eax, ebx

	ret

kwadrat ENDP


f32_main PROC

	push 2
	push 3
	call kwadrat
	add esp, 8

	push 0
	call _ExitProcess@4

f32_main ENDP
END