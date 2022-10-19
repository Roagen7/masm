.686
.model flat


extern _ExitProcess@4 : PROC

public f28_main

.data
x dd ?
y dd ?


.code
f28_main PROC
	
	push 4
	push 3

	lea eax, [esp + 4]
	mov [x], eax ; &x = [esp + 4]
	mov [y], esp ; &y = esp

	mov eax, [x] ; eax = esp + 4
	mov ebx, [y] ; ebx = esp

	mov ecx, [eax] ; ecx = 4
	mov edx, [ebx] ; edx = 3

	push 0
	call _ExitProcess@4

f28_main ENDP
END