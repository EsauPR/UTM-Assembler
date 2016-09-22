.model small 
.stack	
.code
main:	
		mov ax,@data
		mov ds,ax 	

		call lee2
		mov bl,al
		and bl,0Fh
		shr al,4h
		add al,bl
		;call suma
		call imprime
		jmp fin
		
;------------------------------------
lee2:
		call lee1
		shl al,04
		mov bl,al
		call lee1
		add al,bl
		ret

lee1: 	mov ah,01h
		int 21h
		sub al,30h	
	
		cmp al,0Fh
		jle l_fin
		sub al,27h
	
		cmp al,0Fh
		jle l_fin 
		sub al,57h
	l_fin: ret

imprime:mov dl,al
		add dl,30h
		cmp dl,39h
		jle i_fin
		add dl,7h
  i_fin:  mov ah,02h
		int 21h
		ret
imp2:	mov dl,al
		add dl,30h
		cmp dl,39h
		jle i2_fin
		add dl,7h
  i2_fin:  mov ah,02h
		int 21h
		ret
			
fin : 	mov ah,4ch 
		int 21h
		
		
end 