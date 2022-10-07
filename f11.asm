;message box for utf-16 and ascii

.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern __read : proc
extern _MessageBoxA@16 : proc
extern _MessageBoxW@16 : proc
public f11_main

.data 
	helloAscii db 'Witaj swiecie!!!', 0
	helloUTF16 dw 'Z', 'a', 017CH, 00F3H, 0142H, 0107H, ' '
			   dw 'g', 0119H, 015BH, 'l', 0105H, ' '
			   dw 'j', 'a', 017AH, 0144H, 0
	captionA   db 'Window', 0
	captionW   dw 'W', 'i', 'n', 'd', 'o', 'w', 0
.code 

f11_main proc
	
	; message box ascii
	push dword ptr 0
	push dword ptr offset captionA
	push dword ptr offset helloAscii
	push dword ptr 0
	call _MessageBoxA@16
	add esp, 16

	; message box utf-16
	push dword ptr 0
	push dword ptr offset captionW
	push dword ptr offset helloUTF16
	push dword ptr 0
	call _MessageBoxW@16
	add esp, 16

	push dword ptr 0
	call _ExitProcess@4

f11_main endp
end