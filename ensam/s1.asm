.model small 
.stack	
.code
main:	mov ax,@data
		mov ds,ax 	
		call lee2
		mov bl,al
		and bl,0Fh
		shr al,4h
		
		call lee1
		shl al,04
		mov bl,al
		call lee1
		add al,bl
		;call suma
		call imprime
		
		jmp fin