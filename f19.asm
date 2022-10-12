.686
.model	flat

extern _ExitProcess@4 : proc
extern _MessageBoxW@16 : proc

public f19_main

.data

buff db 050H, 04FH, 0C4H, 085H, 0E0H , 0A4H , 0B9H
outp dw 15 dup(0)

.code


utf8toutf16@12 proc ; void utf8toutf16(const char* utf8, wchar_t* utf16, uint32_t utf8_length)
	pop ebp
	pop esi ; text in utf8 
	pop edi ; text in utf16
	pop ecx ; length of utf8 in bytes
	push ecx
	push edi
	push esi
	push ebp

	mov edx, 0 ; utf8 counter
	mov ebx, 0 ; utf16 counter

first_byte:
	mov al, byte ptr [esi + edx]
	rcl al, 1
	jc multibyte

ascii:
	rcr al, 1
	and ax, 00FFH
	mov word ptr [edi + ebx], ax
	add edx, 1
	jmp continue

multibyte:
	rcl al, 2
	jc threebytes

twobytes:
	rcr al, 3
	and al, 00011111B ; 000yyyyy
	and ax, 00FFH
	shl ax, 6 ; 00000yyyyy000000

	mov bp, ax
	xor ax, ax
	mov al, byte ptr [esi + edx + 1]
	and al, 00111111B ; 00xxxxxx
	or bp, ax ; 00000yyyyyxxxxxx
	mov word ptr [edi + ebx], bp
	
	add edx, 2
	jmp continue

threebytes:
	rcr al, 3 
	and al, 00001111B ; 0000zzzz
	and ax, 00FFH
	shl ax, 12
	mov bp, ax

	xor ax, ax
	mov al, byte ptr [esi + edx + 1]
	and al, 00111111B ; 00yyyyyy
	shl ax, 6
	or bp, ax ; zzzzyyyyyy

	xor ax, ax
	mov al, byte ptr [esi + edx + 2]
	and al, 00111111B ; 00xxxxxx
	or bp, ax
	mov word ptr [edi + ebx], bp

	add edx, 3
continue:
	add ebx, 2

	cmp edx, ecx
	jne first_byte
	
	ret
utf8toutf16@12 endp


f19_main proc
lp:
	push dword ptr 7
	push dword ptr offset outp
	push dword ptr offset buff
	
	call utf8toutf16@12
	add esp, 12

	push dword ptr 0
	push dword ptr offset outp
	push dword ptr offset outp
	push dword ptr 0
	call _MessageBoxW@16
	add esp, 16

	push dword ptr 0
	call _ExitProcess@4
f19_main endp
end
