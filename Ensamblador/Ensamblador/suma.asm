.model small 
.stack
.code
main:	mov ax,@data
		mov ds,ax 	

		
	call lee

	mov bl,al

	call lee

	add al,bl
	mov dl,al

	call des
	
	fin : 	mov ah,4ch
			int 21h

	
	lee:	mov ah,01h
			int 21h
			sub al,30h
	
	mayuscula:
			cmp al,0Fh
			jl siguiente
			sub al,7h
	
	minuscula:
			cmp al,0Fh
			jl siguiente
			sub al,20h
	
	siguiente:
			ret
	des:
			mov ah,02h
			add dl,30h
			int 21h
			ret

end