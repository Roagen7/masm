.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.code 
_main PROC

	push 0
	call _ExitProcess@4

_main ENDP
END