.686
.model	flat

extern _ExitProcess@4 : PROC

public f33_main

.data

znaki db 'ania ma psa'
dat db 00010100B
	db 256 dup(0FFH)

u8 db 0F4H, 08FH, 0BFH, 0BFH
u16 dw 2 dup(0)

	db 10 dup(0AH)
pon db 0ah dup(0)
	dw 'A'-'Z'
	dq 2.5
	db 10 dup(0AH)

znak db ?

.code

_9bits PROC ; addr = esi, offset = cl
	xor dx, dx
	or dx, 1111111000000000B
	rol dx, cl
	mov ax, [esi]
	and ax, dx
	and bx, 01FFH
	shl bx, cl
	xor ax, bx
	mov [esi], ax

	ret
_9bits ENDP

_5bits PROC ; addr = esi, offset = cl, num = ax
	
	mov bx, 0FFE0H ; bx = 11..100000
	rol bx, cl ; bx = 1111...11000000111...11
	mov dx, [esi]
	and dx, bx ; dx = yyyyyyy..yy00000yyy...yy
	and ax, 01FH ; ax = 000..00xxxxx
	shl ax, cl ; ax = 00..00xxxxx00..00
	xor dx, ax ; dx = yyyyyy..yyxxxxxyy...yyy
	mov [esi], dx 
	ret
_5bits ENDP

_get3bits PROC ; addr = esi, offset = cl
	mov bx, [esi]
	shr bx, cl ; bl = ?????xxx
	and bl, 07H ; bl = 00000xxx
	and al, 0F8H ; al = yyyyy000
	or al, bl  ; al = yyyyyxxx
	ret
_get3bits ENDP


_nwp PROC ; esi = x, edi = y

lp: 
	cmp esi, edi
	je koniec
	ja kk ; if (esi < edi)
	sub edi, esi ; do edi = edi - esi
	jmp lp 
kk: ; else
	sub esi, edi ; do esi = esi - edi
	jmp lp
koniec:
	ret

_nwp ENDP

_u8u16 PROC
	xor eax, eax

	mov bl, [esi]
	and bl, 00000111B
	movzx ebx, bl
	shl ebx, 18
	or eax, ebx

	mov bl, [esi + 1]
	and bl, 00111111B
	movzx ebx, bl
	shl ebx, 12
	or eax, ebx

	mov bl, [esi + 2]
	and bl, 00111111B
	movzx ebx, bl
	shl ebx, 6
	or eax, ebx

	mov bl, [esi + 3]
	and bl, 00111111B
	movzx ebx, bl
	or eax, ebx

	sub eax, 10000H

	mov ebx, eax
	and bx, 03FFH
	or bx, 0DC00H
	mov [edi + 2], bx

	mov ebx, eax
	shr ebx, 10
	and bx, 03FFH
	or bx, 0D800H
	mov [edi], bx

	ret
_u8u16 ENDP

f33_main PROC
	mov dl, 2
	mov esp, offset znaki

	movzx edx, dl
	mov al, [esp + edx]
	mov [znak], al


	push 0
	call _ExitProcess@4

f33_main ENDP
END