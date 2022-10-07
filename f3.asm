.686
.model flat

extern _ExitProcess@4 : proc
public main_f3

.code
main_f3 proc
	
	mov ecx, 3
	mov eax, 1
lp:
	xor edx, edx
	mul ecx
	add ecx, 2
	cmp ecx, 15
	jne lp

;	call exit
	push byte ptr 0
	call _ExitProcess@4
main_f3 endp
end
