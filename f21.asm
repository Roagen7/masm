.686
.model flat

extern _ExitProcess@4 : proc
public f21_main

.data
text db 'abc'
outp db 2 dup(?) 

.code
f21_main proc
	mov ecx, 2
	mov edx, 1
lp:
	mov al, byte ptr [ecx + text]
	mov bl, byte ptr [ecx + text - 1]

	and al, 00001111B 
	and bl, 00001111B
	shl bl, 4
	or al, bl ; al = bbbbaaaa
	mov byte ptr [outp + edx], al
	dec edx
	sub ecx, 2
	cmp ecx, 0
	jg lp
	jne fin
	
	mov al, byte ptr [text] 
	and al, 00001111B
	mov byte ptr [outp], al

fin:

	push byte ptr 0
	call _ExitProcess@4
f21_main endp
end
