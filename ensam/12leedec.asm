.model small
.stack
.data
back 	db 	' ',0dh,0ah,24h
uno 	db 	'1',24h
datos 	db 	0ffh,0ffh,0ffh,0ffh  
datos2 	db 	00h,00h,00h,02h
result 	db 	00h,00h,00h,00h 
num1 	db 	00h,00h,00h,00h  
num2 	db 	00h,00h,00h,01h
res 	db 	00h,00h,00h,00h 
.code


main:
		mov 	ax,@data
        mov 	ds,ax
        
        call leedec
		;call reto
		mov dx,ax
		call des4
		;call reto

        
        
        ;/*********************************
        call lee_4
        mov cx,ax
        call salto
        
        call lee_4
        mul cx
        call salto
        
        call print_4
        mov dx,ax
        call print_4
        
        .exit 0
        
        ;/*********************************
       
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
		push dx
		add dl,30h
        cmp dl,39h
        jle termina
        add dl,7h
termina:push ax
		mov ah,02h
        int 21h
        pop ax
        pop dx
        ret
        
        
print_2:
		;recibe el dato en dl ( 2 digitos )
		push ax
		push bx
		push dx
		mov bl,dl
        and bl,0Fh
        shr dl,4h
        call print_1
        mov dl,bl
        call print_1
        pop dx
        pop bx
        pop ax
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
;show:
;		push 	ax
;		push 	bx
;		push 	cx
;		push 	dx
		
;		mov		dx,ax
;		call	desp4
;		call 	spc
		
;		mov		dx,bx
;		call	desp4
;		call 	spc		;espacio
		
;		mov		dx,cx
;		call	desp4
;		call 	spc
		
;		pop		dx
;		push	dx
;		call 	desp4
;		call 	reto	;retorno de linea
		
;		pop 	dx
;		pop 	cx
;		pop 	bx
;		pop 	ax
;		ret
end