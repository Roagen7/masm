.686
.model	flat

extern _ExitProcess@4 : proc
extern _MessageBoxW@16 : proc
extern _MessageBoxA@16 : proc

extern __read : proc

public f20_main

.data
	ascii db 256 dup(0)
	outp dw 256 dup(0)
	len dd 0
.code

f20_main proc
	push 256 ; max size
	push dword ptr offset ascii ; location
	push 0 ; keyboard
	call __read
	add esp, 12
	mov dword ptr [len], eax

	mov ecx, dword ptr [len]

capital_ascii:
	dec ecx

	xor ax, ax
	mov al, byte ptr [ascii + ecx]
	
	cmp al, 'a'
	jb continue
	cmp al, 'z'
	ja continue
	sub al, 020H

continue:

	cmp al, 165 
	jne polnext0
	mov ax, 0104H
polnext0:
	cmp al, 134 
	jne polnext1
	mov ax, 0106H
polnext1:
	mov word ptr [outp + ecx * 2], ax
	cmp ecx, 0
	jne capital_ascii

	push 0
	push offset outp
	push offset outp
	push 0
	call _MessageBoxW@16
	add esp, 16

	push 0
	call _ExitProcess@4
	
f20_main endp
end
