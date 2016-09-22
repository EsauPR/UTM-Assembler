.model small
.stack

.code
main: 
	call lee1
	inc al
	call desp1
	
	.exit 0
	
	lee1:
		mov ah,01h
		int 21h
		sub al,30h
		ret 
		;devuelve data en registro ax
	desp1:
		mov ah,02h
		mov dl,al
		add dl,30h
		int 21h
		ret
	getchar:
		mov ah,01h
		int 21h
		ret
		
end