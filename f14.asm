; string to uint with stdcall

.686
.model flat

extern _ExitProcess@4 : PROC
public f14_main

.data
	asciint db '12345'

.code

str2uint PROC ; uint32_t strtouint(char* str, uint32_t len) STDCALL
	; STDCALL
	pop ebp
	pop esi ; memory
	pop ecx ; length
	push ecx
	push esi
	push ebp

	mov ebx, 1 ; ebx = 1
	mov edi, 0 ; edi = 0

	lp: 
		dec ecx ; ecx--
	
		xor edx, edx
		xor eax, eax
		mov al, byte ptr [ecx + esi]
		sub eax, '0'
		mul ebx 
		add edi, eax ; edi += num([ecx + esi]) * ebx
		
		xor edx, edx
		mov eax, ebx
		mov edx, 10
		mul edx
		mov ebx, eax ; ebx = 10 * ebx

		cmp ecx, dword ptr 0
		jne lp

		mov eax, edi
	ret
str2uint ENDP


f14_main PROC
	push dword ptr 5
	push dword ptr offset asciint
	call str2uint


	push 0
	call _ExitProcess@4

f14_main ENDP
END