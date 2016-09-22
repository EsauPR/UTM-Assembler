.model small
.stack
.data
.code
main:call lee1
	 mov bl,al
	 call lee1
	 add al,bl
	 mov dl,al
	 call des1
	 ;call fin
	.exit 0

lee1:mov ah,01h
	int 21h
	
	SUB al,30h
	cmp al,0fh
	JLE rango	;Esta en el rango.
	SUB al,7h
	cmp al,0fh
	JLE rango	;Esta en el rango.
	SUB AL,20h
	
	rango:mov cl,al
	mov ch,0
	mov dl,cl
	mov dh,ch

	
ret

des1: mov ah,02h
	  mov dl,al
	  add dl,30h
	  int 21h
ret
end
