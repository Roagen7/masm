;max array value with STDCALL

.686
.model flat

extern _ExitProcess@4 : PROC
public f15_main

.data
	array db 20, 10, 50, 25, 1, 16, 59, 32, 23, 5, 34
	len dd 11
.code

max PROC ; uint8_t max(uint8_t* address, uint32_t length)
	
	; STDCALL
	pop ebp 
	pop esi ; address
	pop ecx ; length
	push ecx
	push esi
	push ebp
	
	xor eax, eax
	xor ebx, ebx
	mov al, byte ptr [esi] ; eax = esi[0]
lp:
	dec ecx ; ecx--

	mov bl, byte ptr [esi + ecx]
	cmp al, bl
	jae co  
	mov al, bl ; al = max(al, bl)
co:
	cmp ecx, 0
	jne lp

	ret
max ENDP

f15_main PROC
	push dword ptr [len]
	push dword ptr offset array

	call max 
	add esp, 8

	push 0
	call _ExitProcess@4

f15_main ENDP
END