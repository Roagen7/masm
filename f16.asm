;UTF8 to UTF16

.686	
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public f16_main

.data
buff	db	50H, 6FH, 0C5H, 82H, 0C4H, 85H, 63H, 7AH
		db	65H, 6EH,  69H, 65H,  20H, 7AH, 6FH, 73H
		db	74H, 61H, 0C5H, 82H,  6FH, 20H, 6EH, 61H
		db	77H, 69H, 0C4H, 85H,  7AH, 61H, 6EH, 65H
		db	2EH, 0E2H, 91H, 0A4H	
		 ;P    ; O		;¹ 2B	  ;some weird sign 3B
buff2 db 050H, 04FH, 0C4H, 085H, 0E0H , 0A4H , 0B9H

output	dw	37 dup (0)	

.code
f16_main PROC
	mov edx, 33
	mov esi, dword ptr offset buff
	mov ecx, 0
	mov edi, 0
	xor ebx, ebx
lp:
	mov bl, byte ptr [esi + ecx]
	rcl bl, 1
	jnc ascii

; multibyte
two:
	rcl bl, 2
	jc three

; has two bytes of form 110yyyyy 10xxxxxx
	mov al, byte ptr [esi + ecx]
	and al, 00011111B ; 000yyyyy
	xor bx, bx 
	mov bl, al ; 000yyyyy
	shl bx, 6 ; 0000yyyy y00000000
	mov al, byte ptr [esi + ecx + 1]
	and al, 00111111B ; 00xxxxxx
	or bl, al ; bx = 00000yyy yyxxxxxx
	mov word ptr [output + edi], bx

	add ecx, 2
	jmp continue

three:
	mov al, byte ptr [esi + ecx] ; 1110zzzz
	and al, 00001111B
	xor bx, bx
	mov bl, al
	shl bx, 12
	xor ax, ax
	mov al, byte ptr [esi + ecx + 1]
	and al, 00111111B
	shl ax, 6
	or bx, ax
	xor ax, ax
	mov al, byte ptr [esi + ecx + 2]
	and al, 00111111B
	or bx, ax

	mov word ptr [output + edi], bx

	add ecx, 3
	jmp continue 
ascii:
	xor ax, ax
	mov al, byte ptr [esi + ecx]

	mov word ptr [output + edi], ax

	inc ecx
	jmp continue

continue:
	add edi, 2
	cmp ecx, edx
	jne lp

	push	dword ptr 0
	push	dword ptr OFFSET output
	push	dword ptr OFFSET output
	push	dword ptr 0
	call	_MessageBoxW@16
	add esp, 16

	push 0
	call _ExitProcess@4

f16_main ENDP
END