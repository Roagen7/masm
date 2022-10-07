.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern __read : proc

public f10_main

.data 
funny db 'zazó³æ gêœl¹ jaŸñ', 0AH


.code 

iso2latin_2 proc
	


iso2latin_2 endp

f10_main proc
	xor eax, eax
	mov al, byte ptr [funny + 3]
	mov byte ptr [funny + 3], 0AH

	push dword ptr 0
	call _ExitProcess@4

f10_main endp
end