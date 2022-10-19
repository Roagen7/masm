.686
.model flat

extern __read : PROC
extern _ExitProcess@4 : PROC

public f26_main

.data
;zmienna 
tex db 255 dup(?)

.code 

chartoint PROC ; int chartoint(char* chars, int len)
	; [..., ret,ret,ret,ret, char,char,char,char, len,len,len,len]

	mov esi, [esp + 4] ; char* chars
	mov ecx, [esp + 8] ; int len

	mov ebx, 1 ; ebx = 1
	xor ebp, ebp ; ebp = 0
	
lp:
	dec ecx ; ecx--
	movzx eax, byte ptr [esi + ecx] ; eax = current char ascii value
	sub eax, '0' ; eax = current digit value
	xor edx, edx ; edx = 0
	mul ebx ; eax *= ebx so we get 10^n * (digit value)
	
	add ebp, eax ; ebp += eax

	xor edx, edx
	mov eax, ebx
	mov ebx, 10
	mul ebx
	mov ebx, eax ; ebx *= 10
	
	cmp ecx, 0
	jne lp

	mov eax, ebp

	ret

chartoint ENDP


f26_main PROC
	
	push dword ptr 255
	push offset [tex]
	push dword ptr 0
	call __read

	add esp, 12
	dec eax
	push eax
	push offset [tex]
	call chartoint

	push dword ptr 0
	call _ExitProcess@4

f26_main ENDP
END