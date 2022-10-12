.686
.model flat

extern _ExitProcess@4 : PROC

public f17_main

.data
array db 15, 3, 40, 9, 72, 34, 12

.code

selectionsort PROC ; void selectionsort(uint8_t* arr, uint32_t len)
	pop ebp
	pop esi
	pop ecx
	push ecx
	push esi
	push ebp

	; for cx = n to 1
	
lp:
	dec ecx ; cx --
	mov al, byte ptr [esi + ecx] ; max = esi[ecx] 
	mov edi, ecx ; max_index = ecx

	mov edx, ecx

	lp_max:
		cmp al, byte ptr [esi + edx]
		jae continue
		mov al, byte ptr [esi + edx] ; al = max(al, esi[edx])
		mov edi, edx ; max_index = edx
	continue:
		dec edx  ; edx--
		cmp edx, 0
		jge lp_max
	
	mov dl, byte ptr [esi + ecx]
	mov byte ptr [esi + edi], dl
	mov byte ptr [esi + ecx], al ; swap(esi[edi], esi[ecx])

	cmp ecx, 0
	jne lp

	ret
selectionsort ENDP

f17_main PROC
	
	push dword ptr 7
	push dword ptr offset array
	call selectionsort	

	push dword ptr 0
	call _ExitProcess@4

f17_main ENDP
END