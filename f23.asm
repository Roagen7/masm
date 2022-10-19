;utf16 to utf8

.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public f23_main

.data
textUTF16  dw 'o', 't', 0105H, ' ', 'k', 'o', 't', 0CC41H, ' ', 0D83DH, 0DC08H, 0H
textUTF8 db 40 dup(0)

.code 

f23_main PROC
	
	push 0
	push offset textUTF16
	push offset textUTF16
	push 0
	call _MessageBoxW@16 
	add esp, 16

	mov ecx, 0 ; utf16 counter
	mov edi, 0 ; utf8 counter

lp:
	mov ax, word ptr [textUTF16 + ecx]
	and ax, 1101100000000000B
	cmp ax, 1101100000000000B
	je fourbytes
	mov ax, word ptr [textUTF16 + ecx]
	cmp ax, 007FH
	jbe ascii
	cmp ax, 07FFH
	jbe twobytes
	cmp ax, 0FFFFH
	jbe threebytes

ascii:
	mov byte ptr [textUTF8 + edi], al
	inc edi
	jmp continue
twobytes:
	mov bl, al
	and bl, 00111111B
	or bl, 10000000B ; 10xxxxxx
	mov byte ptr [textUTF8 + edi + 1], bl
	rcr ax, 6
	and al, 000111111B
	or al, 11000000B
	mov byte ptr [textUTF8 + edi], al
	add edi, 2
	jmp continue
threebytes:
	mov bl, al
	and bl, 00111111B
	or bl, 10000000B
	mov byte ptr [textUTF8 + edi + 2], bl ; 10xxxxxx
	
	mov bx, ax
	shr bx, 6
	and bl, 00111111B
	or bl, 10000000B
	mov byte ptr [textUTF8 + edi + 1], bl ; 10yyyyyy

	mov bx, ax
	shr bx, 12
	and bl, 00001111B
	or bl, 11100000B
	mov byte ptr [textUTF8 + edi], bl

	add edi, 3
	jmp continue
fourbytes:
	mov ax, word ptr [textUTF16 + ecx + 2]
	and ax, 03FFH ; first 10 bits
	mov bl, al
	and bl, 00111111B
	or bl, 10000000B
	mov byte ptr [textUTF8 + edi + 3], bl
	mov bl, al
	shr bl, 6 
	mov dl, ah
	and dl, 00000011B
	shl dl, 2
	or bl, dl
	mov ax, word ptr [textUTF16 + ecx]
	mov dl, al
	and dl, 00000011B
	shl dl, 4
	or bl, dl
	or bl, 10000000B
	mov byte ptr [textUTF8 + edi + 2], bl
	mov dl, al
	shr dl, 2
	or dl, 10010000B
	mov byte ptr [textUTF8 + edi + 1], dl
	mov dl, ah
	and dl, 00000011B
	or dl, 11110000B
	mov byte ptr [textUTF8 + edi], dl

	add edi, 4
	add ecx, 2
	jmp continue
continue:
	add ecx, 2
	cmp word ptr [textUTF16 + ecx], 0
	jne lp

	push dword ptr 0
	call _ExitProcess@4

f23_main ENDP
END