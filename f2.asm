; fibonacci

.686
.model flat

extern __write : proc
extern _ExitProcess@4: proc
public main_f2

.data
hello	db 'Hello world!', 10

.code

fibonacci proc ; return n-th fibonacci number, n=ecx, f(n) -> eax
	push edx
	push ebx

	mov edx, 1 ; handle f(0), f(1)
	mov eax, 1
	cmp ecx, 0 
	je	cleanup
	cmp	ecx, 1
	je	cleanup

	sub ecx, 1
next:
	dec ecx
	mov	ebx, eax 
	add ebx, edx ; f next = f prev + f prev prev
	mov	edx, eax ; f prev prev = f prev 
	mov eax, ebx ; f prev = f next
	cmp ecx, 0
	jne next
cleanup:
	pop ebx
	pop edx
	ret
fibonacci endp

main_f2 proc
	mov ecx, 5
	call fibonacci
	push 0
	call _ExitProcess@4
main_f2 endp
end
