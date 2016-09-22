clear_screen macro
	pusha
	mov ax, 0600h
	mov bh, 00001111b
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	popa
endm