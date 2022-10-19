; game of life

.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

size_w equ 8
size_h equ 8

public f36_main

.data
state db 0, 0, 0, 0, 0, 0, 0, 0
	  db 0, 0, 0, 0, 0, 0, 0, 0
	  db 0, 0, 0, 1, 0, 0, 0, 0
	  db 0, 0, 0, 0, 1, 0, 0, 0
	  db 0, 0, 1, 1, 1, 0, 0, 0
	  db 0, 0, 0, 0, 0, 0, 0, 0
	  db 0, 0, 0, 0, 0, 0, 0, 0
	  db 0, 0, 0, 0, 0, 0, 0, 0

next_state db size_w * size_h dup(0)

buff db ?

.code

_printstate PROC ; write current game state
	
xor esi, esi
xor edi, edi

char:
	mov al, [state + edi]
	add al, '0'
	
	sub esp, 1
	mov byte ptr [esp], al 
	mov ebx, esp

	push 1
	push ebx
	push 1
	call __write
	add esp, 13

	inc edi
	inc esi
	cmp esi, size_w
	jne continue

	xor esi, esi
	sub esp, 1
	mov byte ptr [esp], 0AH
	mov ebx, esp

	push 1
	push ebx
	push 1
	call __write
	add esp, 13

continue:

	cmp edi, size_w * size_h
	jne char

	ret

_printstate ENDP

_calculate_offset PROC ; x in ebx y in ecx, output address in eax
	xor edx, edx
	mov eax, size_w
	mul ecx
	add eax, ebx
	ret
_calculate_offset ENDP

_nextstate PROC
	mov ebx, 1 ; x
	mov ecx, 1 ; y

lp: 
	xor esi, esi

	dec ebx ; (x-1, y)
	call _calculate_offset	
	movzx eax, [state + eax]
	add esi, eax

	dec ecx ; (x-1, y-1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	inc ebx ; (x, y-1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	inc ebx ; (x+1, y-1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	inc ecx ; (x+1, y)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	inc ecx ; (x+1, y+1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	dec ebx ; (x, y+1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax

	dec ebx ; (x-1, y+1)
	call _calculate_offset
	movzx eax, [state + eax]
	add esi, eax


	inc ebx
	dec ecx
	call _calculate_offset

	movzx edx, [state + eax]
	cmp edx, 1
	jne dead

alive:
	cmp esi, 2
	je continue
	cmp esi, 3
	je continue
	mov [next_state + eax], 0 ; kill if it has less that 2 or more that 3 neighbors
	jmp continue
dead:
	cmp esi, 3
	jne continue
	mov [next_state + eax], 1 ; springs to life if it has exactly 3 neighbors
continue:
	cmp ebx, size_w - 2 
	jne not_next
	mov ebx, 1
	inc ecx ; next row
	jmp again
not_next:
	inc ebx
again:
	cmp eax, size_w * size_h - 2
	jne lp 

	ret
_nextstate ENDP

_nextstate_to_state PROC

	mov ecx, size_w * size_h

lp:
	dec ecx
	mov al, [next_state + ecx]
	mov [state + ecx], al
	cmp ecx, 0
	jne lp
	ret
_nextstate_to_state ENDP

_state_to_nextstate PROC
	mov ecx, size_w * size_h

lp:
	dec ecx
	mov al, [state + ecx]
	mov [next_state + ecx], al
	cmp ecx, 0
	jne lp
	ret

_state_to_nextstate ENDP


f36_main PROC

	mov byte ptr [esp], 0AH
	mov ebx, esp

game:
	call _printstate

	push 1
	push offset buff
	push 0
	call __read
	add esp, 12

	push 1
	push ebx
	push 1
	call __write
	add esp, 13
	call _state_to_nextstate	
	call _nextstate
	call _nextstate_to_state	

	cmp [buff], 'F'
	jne game
	

	push 0
	call _ExitProcess@4

f36_main ENDP
END


