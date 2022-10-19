.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; int _write(int fd,const void *buffer,unsigned int count)
extern __read : PROC ; int _read(int const fd, void * const buffer,unsigned const int count)

keyboard equ 0
console  equ 1

public f30_main

.data

tex db 255 dup(?)
len dd ?
lat db 255 dup(0)
utf db 255 dup(0) ; utf16

.code



f30_main PROC
	
	; read input
	push 255
	push offset tex
	push keyboard
	call __read
	add esp, 12

	mov [len], eax ; len = eax
	mov ecx, eax

lp:
	dec ecx
	mov al, [tex + ecx]

	cmp al, 'a'
	jb pol
	cmp al, 'z'
	ja pol

	sub al, 20H ; to capital
	mov bl, al
pol:
	cmp al, 0A5H ; ¹
	jne pol2
	mov al, 0A4H
	mov bl, 0A5H
pol2:
	cmp al, 086H ; æ
	jne pol3
	mov al, 08FH
	mov bl, 0C6H
pol3:
	cmp al, 0A9H ; ê
	jne pol4
	mov al, 0A8H
	mov bl, 0CAH
pol4:
	mov [tex + ecx], al
	mov [lat + ecx], bl
	cmp ecx, 0
	jne lp

	; write input
	mov ecx, [len]
	push ecx
	push offset tex
	push console
	call __write
	add esp, 12

	push 0
	push offset lat
	push offset lat
	push 0
	call _MessageBoxA@16

	mov ecx, [len]
lputf:
	dec ecx

	movzx ax, byte ptr [tex + ecx] ; ax = 00000000ascii

polutf:
	cmp al, 0A4H
	jne polutf2
	mov ax, 0104H
polutf2:
	cmp al, 08FH
	jne polutf3
	mov ax, 0106H
polutf3:
	cmp al, 0A8H
	jne polutf4
	mov ax, 0118H
polutf4:
	mov word ptr [utf + ecx * 2], ax

	cmp ecx, 0
	jne lputf

	push 0
	push offset utf
	push offset utf
	push 0

	call _MessageBoxW@16


	push 0
	call _ExitProcess@4

f30_main ENDP
END