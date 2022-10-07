; polskie znaki hello world

.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern __read : proc
public f8_main

.data
hello db 'Cze', 098H, 086H,' ', 098H,'wiecie!', 0AH

.code 
f8_main proc
	
	push dword ptr 14
	push dword ptr offset hello
	push dword ptr 1
	call __write
	add esp, dword ptr 12

	push dword ptr 0
	call _ExitProcess@4

f8_main endp
end