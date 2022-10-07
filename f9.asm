; to upper case with polish letters

.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern __read : proc
public f9_main

.data
hello db 'Cze', 098H, 086H,' ', 098H,'wiecie!', 0AH
storage dd 255 dup(?)

.code 

say_hello proc
	push dword ptr 15
	push dword ptr offset hello
	push dword ptr 1
	call __write
	add esp, dword ptr 12
	ret
say_hello endp

get_msg proc
	push dword ptr 255
	push dword ptr offset storage
	push dword ptr 0
	call __read
	add esp, dword ptr 12
	ret
get_msg endp

to_upper_msg proc ; implies length is in ecx
lp:
	dec ecx
	mov al, byte ptr [storage + ecx]
	cmp al, 'a'
	jl cont
	cmp al, 'z'
	jg cont
	sub al, 020H
	mov byte ptr [storage + ecx], al
cont:
	cmp ecx, 0
	jnz lp

	ret
to_upper_msg endp

pol_to_upper_msg proc
lp:
	dec ecx
	mov al, byte ptr [storage + ecx]	
	
	cmp al, 0A5H ; π
	jne cont1
	mov al, 0A4H ; •
cont1:
	cmp al, 086H ; Ê
	jne cont2
	mov al, 08FH ; ∆
cont2:
	cmp al, 0A9H ; Í
	jne cont3
	mov al, 0A8H ;  
cont3:
	cmp al, 088H ; ≥
	jne cont4
	mov al, 09DH ; £
cont4:
	cmp al, 0E4H ; Ò
	jne cont5
	mov al, 0E3H ; —
cont5:
	cmp al, 0A2H ; Û
	jne cont6
	mov al, 0E0H ; ”
cont6:
	cmp al, 098H ; ú
	jne cont7
	mov al, 097H ; å
cont7:
	cmp al, 0ABH ; ü
	jne cont8
	mov al, 08DH ; è
cont8:
	cmp al, 0BEH ; ø
	jne cont9
	mov al, 0BDH ; Ø
cont9:
	mov byte ptr [storage + ecx], al
	cmp ecx, 0
	jnz lp

	ret


pol_to_upper_msg endp

put_msg proc
	push eax
	push dword ptr offset storage
	push dword ptr 1
	call __write
	add esp, dword ptr 12
	ret
put_msg endp

f9_main proc
	
	call say_hello
	call get_msg
	push eax
	mov ecx, eax
	call to_upper_msg
	pop ecx
	push ecx
	call pol_to_upper_msg
	
	call put_msg

	push dword ptr 0
	call _ExitProcess@4

f9_main endp
end