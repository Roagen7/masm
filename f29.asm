.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC

public f29_main
.data
	tytul_Unicode dw 'T','e','k','s','t',' ','w',' '
				  dw 'f','o','r','m','a','c','i','e',' '
				  dw 'U','T','F','-','1','6', 0

	tekst_Unicode db 03DH, 0D8H, 0CH, 0DCH
				  dw 0D83DH
				  db 037H, 0DCH, 0, 0

	tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0

	tekst_Win1250 db 'Ka¿dy znak zajmuje 8 bitów', 0

.code
f29_main PROC

	push 0 
	push OFFSET tytul_Win1250
	push OFFSET tekst_Win1250
	push 0 ; NULL
	call _MessageBoxA@16

	push 0
	push OFFSET tytul_Unicode
	push OFFSET tekst_Unicode
	push 0	
	call _MessageBoxW@16

	push 0 ; kod powrotu programu
	call _ExitProcess@4
f29_main ENDP
END