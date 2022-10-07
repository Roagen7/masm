; sum arrays
.686
.model flat

extern _ExitProcess@4 : PROC
public f5_main

.data
	arrB db 13, 2, 4, 5, 12
	arrD dword 13, 2, 4, 5, 12
.code

sumB PROC ; al <- sum of array of bytes, first element address in edx, size in ecx
	xor al, al 
lp:
	dec ecx
	add al, byte PTR [edx + ecx] ; addition of al + element of array
	cmp ecx, 0
	jne lp
	ret

sumB ENDP

sumD PROC ; eax <- sum of array of dwords, first element address in edx, size in ecx
	xor eax, eax
lp: 
	dec ecx
	add eax, dword PTR [edx + ecx * 4]
	cmp ecx, 0
	jne lp
	ret
sumD ENDP

f5_main PROC
	mov ecx, 5
	lea edx, arrD
	call sumD

	push 0	
	call _ExitProcess@4
f5_main ENDP
END