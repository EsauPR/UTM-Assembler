.model small
.stack
.data
.code
main: 
	call leeDosNum
	mov dh,al
	call leeDosNum
	add al,dh
	call impDos
.exit 0

leeDosNum:
	call leeNum
	shl al,4
	mov bl,al
	call leeNum
	add al,bl
	ret
public
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
	