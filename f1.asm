; call to messagebox

.686
.model flat

extern _ExitProcess@4 : proc
extern __write : proc
extern _MessageBoxA@16 : proc
public main_f1

.data
clicked_ok		db 'OK', 0
clicked_cancel	db 'Cancel', 0
header			db 'Window title', 0
body			db 'Window body', 0

.code
messagebox proc		; wrapper for messagebox, write message at edx, window title at ebx
					; int MessageBox(HWND hWnd, LPCTSTR lpText,LPCTSTR lpCaption, UINT uType);
	push 1
	push edx
	push ebx
	push 0
	call _MessageBoxA@16
	ret
messagebox endp

strlen proc			; take null-terminated string pointed by edx,  length -> eax
	push ebx
	mov eax, edx
innz:
	inc eax			; take nex char
	mov bl, [eax]	
	cmp bl, 0		; check if terminates with null
	jne innz		
	sub eax, edx	; if null, len = eax - edx
	
	pop ebx
	ret
strlen endp

main_f1 proc
	lea edx, body
	lea ebx, header
	call messagebox ; create messagebox with ebx header, edx body
	cmp eax, 1		; user pressed OK
	je	on_ok
	lea	edx, clicked_cancel	
	jmp continue
on_ok:
	lea edx, clicked_ok
continue:
	call strlen		; get string length
	push eax
	push edx
	push dword PTR 1
	call __write    ; write hello to screen

	push 0			; exit with success
	call _ExitProcess@4
main_f1 endp
end