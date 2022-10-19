.686
.model flat

extern _ExitProcess@4 : PROC

public f35_main

.data

src db 0,1,1,0,0,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,0,0,1,1,1
dest db 4 dup(0)

stale	DW 2,1
napis dw 10 dup (3), 2
tekst db 7
	  dq 1

v2 dw ?
qxy dw 254, 255, 256
bigendian db 44H, 33H, 22H, 11H 

reserve dq 0CCCCCCCCCCCCCCCCH, 0CCCCCCCCCCCCCCCCH
	    dw 4 dup (0CCCCH), 20
		db 10 dup (0AAH)

.code 

conv PROC ; compress src to 4 bytes in dest
	mov esi, offset src
	mov edi, offset dest

	xor edx, edx
	xor al, al
	mov cl, 8

lpo:
	dec cl
	mov bl, [esi + edx]
	shl bl, cl
	or al, bl
	inc edx

	cmp cl, 0
	jne next
	add cl, 8
	mov [edi], al
	inc edi
	xor al, al
next:
	cmp edx, 25
	jne lpo

	mov [edi], al
	sub edi, 3
	ret
conv ENDP

xornoxor PROC
	
	mov edi, 0FF00H
	mov esi, 00FF0H

	;xor edi, esi
	; edi=

	mov eax, edi
	not eax
	and eax, esi

	mov ebx, esi
	not ebx
	and ebx, edi

	or eax, ebx
	mov edi, eax

	ret

xornoxor ENDP

u2dozm PROC
	
	mov ebx, 23
	rcl ebx, 1
	pushf
	rcr ebx, 1
	popf
	jnc koniec ; if not negative then ready
	not ebx
	inc ebx
	or ebx, 80000000H

koniec:
	ret

u2dozm ENDP

shiftleft PROC
	mov eax, 0FFFFFFFFH
	mov ebx, 0FFFFFFFFH
	mov ecx, 0FFFFFFFFH
	
	clc
	rcl eax, 1
	rcl ebx, 1
	rcl edx, 1

	jnc koniec
	or al, 1

koniec:

	ret
shiftleft ENDP

nobswap PROC
	mov ebx, offset bigendian

	mov al, byte ptr [ebx]
	shl eax, 8
	mov al, [ebx + 1]
	shl eax, 8
	mov al, [ebx + 2]
	shl eax, 8
	mov al, [ebx + 3]

	ret

nobswap ENDP

countones PROC
	xor eax, eax
	mov ax, 1010110111011000B

	xor cl, cl
lp:
	shr eax, 1
	jnc continue
	inc cl
continue:
	cmp eax, 0
	jne lp

	ret
countones ENDP

f35_main PROC

	mov edx, 0A0B0C0DH
	xchg dl, dh
	bswap edx
	xchg dl, dh

	call countones

	push 0
	call _ExitProcess@4

f35_main ENDP
END