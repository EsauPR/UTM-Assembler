.model small ;
.stack 
.data
.code
main:
	call leeCuatro ;
	mov cx,ax
	call leeCuatro
	add ax,cx
	jnc continua
	push ax
	mov dl,'1'	
	mov ah,02h
	int 21h
	pop ax
	continua:
		call Imprimecuatro
.exit 0

leeCuatro:
	call leeDosNum
	push ax
	call leeDosNum
	pop bx
	mov ah,bl
	ret
	
leeDosNum:
	call leeNum
	shl al,4
	mov bl,al
	call leeNum
	add al,bl
	ret
Imprimecuatro:
	push ax
	mov al,ah
	call impdos
	pop ax
	call impdos
	ret
leeNum:
	mov ah,01h
	int 21h
	sub al,30h
	cmp al,10h
	jl num
	cmp al,30h
	jl may
	sub al,20h
	may:
	sub al,07h
	num:
	ret

toChar:
	cmp al,9h
	jle numero
	add al,7h
	numero: 
	add al,30h
	ret

imprime:
	mov ah,02h
	mov dl,al
	int 21h
	ret
	
impDos:
	mov bl,al
	and bl,0Fh
	shr al,4h
	call toChar
	call imprime
	mov al,bl
	call toChar
	call imprime
	ret
	
end
	