.model small 
.stack	
.code
main:	
		mov ax,@data
		mov ds,ax 	
		call lee1
		mov bl,al
		call lee1
		add al,bl
		call imprime
		jmp fin
	
;--------------------!!funciones!!-----------------

lee1: 	
		mov ah,01h
		int 21h
		sub al,30h	
	
		cmp al,0Fh
		jle l_fin
		sub al,27h
	
		cmp al,0Fh
		jle l_fin 
		sub al,57h
		l_fin: ret

imprime:
		mov dl,al
		add dl,30h
		cmp dl,39h
		jle acaba
		add dl,7h
  		acaba:  mov ah,02h
		int 21h
		ret
	
fin : 	mov ah,4ch 
		int 21h
				
end 