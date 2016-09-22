.model small
.stack
.data
back db ' ',0dh,0ah,24h
uno db '1',24h     
.code


main:
		mov ax,@data
        mov ds,ax
        
       call suma_4
       
fin: 	.exit 0

suma_2: call lee_2
		mov cl,al
		call salto
		call lee_2
		mov dl,al
		call salto
		add dl,cl
		jnc acaba
		call carrie
		acaba:
		call print_2
		ret


suma_4:; no recibe ni regresa nada
		call lee_4
        mov cx,ax ;p1
        ;call salto
        call lee_4
        mov dx,ax ;p2
        call salto
        call lee_4 
        mov bx,ax ;p3
        push bx
        call lee_4 ;p4 se quedo en ax
        pop bx
          
        add dx,ax ;sumo p2 y p4
        ;jnc imp
        push dx
        adc cx,bx
        mov dx,cx
        call salto
        jnc imp
        ;call salto
        call carrie
        imp: ;call salto 
        	 call print_4
        pop dx
        call print_4
       ret
carrie:
		push ax
		push dx
		mov dx ,offset uno
 		mov ah,09h
		int 21h
		pop dx
		pop ax
		ret


lee_1:  ;recibe nada
		mov ah,01h
        int 21h
        sub al,30h    
    
        cmp al,0Fh
        jle return
        sub al,07h
        
        cmp al,0Fh
        jle return
        sub al,20h

        ;retorna el valor en al ( 1 digitos son 4 bits ) 
        return: ret

    	
lee_2:  ;recibe nada
		call lee_1
        shl al,04h
        push bx
        mov bl,al
        call lee_1
        add al,bl
       	pop bx
       	;retorna el valor en al ( 2 digitos son 8 bits )
        ret
        
        
lee_4:	;recibe nada
		call lee_2
		push ax
		call lee_2
		pop bx
		mov ah,bl
		;retorna el valor en ax ( 4 digitos son 16 bits )
		ret
        
        	
print_1:
		;recibe el valor en dl ( 1 digito )
		add dl,30h
        cmp dl,39h
        jle termina
        add dl,7h
termina:push ax
		mov ah,02h
        int 21h
        pop ax
        ret
        
        
print_2:
		;recibe el dato en dl ( 2 digitos )
		mov bl,dl
        and bl,0Fh
        shr dl,4h
        call print_1
        mov dl,bl
        call print_1
        ret
        
print_4 :
		;recibe el dato en dx ( 4 digitos )
		push dx
		mov dl,dh
		call print_2
		pop dx
		call print_2
		ret        


salto: 
		push ax
		push dx
		mov dx ,offset back
		mov ah,09h
		int 21h
		pop dx
		pop ax
		ret

end