; to upper case utf16, with polish letters

.686
.model flat

extern __read : proc
;int MessageBox(HWND hWnd,LPCTSTR lpText, LPCTSTR lpCaption, UINT uType);
extern _MessageBoxA@16 : proc
extern _MessageBoxW@16 : proc
extern _ExitProcess@4 : proc
public f12_main

.data
	len db ?
	ascii db 256 dup(?)
	utf16 dw 256 dup(0)

	caption dw 'U', 'T', 'F', 0

.code

to_upper proc ; implies length is in ecx
lp:
	dec ecx
	mov al, byte ptr [ascii + ecx]
	cmp al, 'a'
	jl cont
	cmp al, 'z'
	jg cont
	sub al, 020H
	mov byte ptr [ascii + ecx], al
cont:
	cmp ecx, 0
	jnz lp

	ret
to_upper endp

to_utf proc
	xor ecx, ecx
	mov cl, byte ptr [len]

lp:
	dec cl
	xor ax, ax
	mov al, byte ptr [ascii + ecx]

	; polish conversion
	cmp al, 0A5H ; π
	jne cont1
	mov ax, 0104H ; •
cont1:
	cmp al, 086H ; Ê
	jne cont2
	mov ax,  0106H; ∆
cont2:
	cmp al, 0A9H ; Í
	jne cont3
	mov ax, 0118H ;  
cont3:
	cmp al, 088H ; ≥
	jne cont4
	mov ax, 0141H ; £
cont4:
	cmp al, 0E4H ; Ò
	jne cont5
	mov ax, 0143H ; —
cont5:
	cmp al, 0A2H ; Û
	jne cont6
	mov ax, 00D3H ; ”
cont6:
	cmp al, 098H ; ú
	jne cont7
	mov ax, 015AH ; å
cont7:
	cmp al, 0ABH ; ü
	jne cont8
	mov ax, 0179H ; è
cont8:
	cmp al, 0BEH ; ø
	jne cont9
	mov ax, 017BH ; Ø
cont9:

	mov word ptr [utf16 + ecx * 2], ax
	cmp ecx, 0
	jnz lp

	ret
to_utf endp

f12_main proc
	xor eax, eax
	push 256 ; max size
	push dword ptr offset ascii ; location
	push 0 ; keyboard
	call __read
	add esp, 12
	mov byte ptr [len], al
	
	mov ecx, eax
	call to_upper		

	call to_utf

	push dword ptr 0
	push dword ptr offset caption
	push dword ptr offset utf16
	push dword ptr 0
	call _MessageBoxW@16

	add esp, 20

	push byte ptr 0
	call _ExitProcess@4
f12_main endp
end
