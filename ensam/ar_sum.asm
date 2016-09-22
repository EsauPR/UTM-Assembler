.model small
.stack
.data
back 	db 	' ',0dh,0ah,24h
uno 	db 	'1',24h  

datos 	db 	0ffh,0ffh,0ffh,0ffh 
datos2 	db 	00h, 00h, 00h, 02h
result 	db 	00h, 00h, 00h, 00h
.code


main:
		mov 	ax,@data
        mov 	ds,ax

        lea 	bx,datos

        mov 	dx,0h
        mov 	cx,4

        meter:
        		push 	[bx]
        	   	add 	bx,1
        loop meter

        mov 	cx,0h ;la ocupare para el ciclo
        mov 	ax,0h ; cuenta carrie al

        lea 	bx,datos2
        pop 	dx
        adc  	dl,[bx +3]

        jnc 	s2
        mov 	al,1
        s2:
        mov 	result[3],dl
        lea 	bx,datos2
        pop 	dx
        add 	dl,al
        jnc 	s
        mov 	al,1
        mov 	cl,1; porque en la siguente no va a haber acarreo, entonces cuento aqui y aumento en la siguiene suma
        s:
        mov 	al,0h
        add  	dl,[bx +2]
        jnc 	s7
        mov 	al,1
        s7:
        mov 	result[2],dl
       ;aqui aumento carrie dl,al
        mov 	al,cl
        mov 	cx,0h

        lea 	bx,datos2
        pop 	dx
        add 	dl,al

        jnc 	s1
        mov 	al,1
        mov 	cl,1; porque en la siguente no va a haber
        s1:	
        mov 	al,0h
        add  	dl,[bx +1]

        jnc 	s4
        mov 	al,1
        s4:
        mov 	result[1],dl
       ;aqui aumento carrie dl,al
        mov 	al,cl
        mov 	cx,0h

        lea 	bx,datos2
        pop 	dx
        add 	dl,al

        jnc 	s5
        mov 	al,1
        mov 	cl,1
        s5: 
        mov 	al,0h
        add  	dl,[bx]
        ;mov al,0h
        jnc 	s6
        mov 	al,1
        s6:
        mov 	result[0],dl

   ;------ imprime salida------     
        cmp 	cl,1
        jne 	resultado
       	call 	carrie
        mov 	cx,0
        
        resultado: 
        mov 	cx,4
        lea 	bx,result
        recorre:
        mov 	dl,[bx]
        call 	print_2
        add 	bx,1
		loop 	recorre
        
fin: 	
		.exit 0

c: 
		push 	dx
   		push 	bx
  		mov		dx,cx
   		call 	print_2
		pop 	bx
	   	pop 	dx
	  	ret
   
suma_2: call 	lee_2
		mov 	cl,al
		call	salto
		call 	lee_2
		mov 	dl,al
		call 	salto
		add 	dl,cl
		jnc 	acaba
		call 	carrie
		acaba:
		call 	print_2
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
    
        cmp 	al,0Fh
        jle 	return
        sub 	al,07h
        
        cmp 	al,0Fh
        jle 	return
        sub 	al,20h

        ;retorna el valor en al ( 1 digitos son 4 bits ) 
        return: 	ret

    	
lee_2:  ;recibe nada
		call 	lee_1
        shl 	al,04h
        push 	bx
        mov 	bl,al
        call 	lee_1
        add 	al,bl
       	pop 	bx
       	;retorna el valor en al ( 2 digitos son 8 bits )
        ret
        
        
lee_4:	;recibe nada
		call 	lee_2
		push 	ax
		call 	lee_2
		pop 	bx
		mov 	ah,bl
		;retorna el valor en ax ( 4 digitos son 16 bits )
		ret
        
        	
print_1:
		;recibe el valor en dl ( 1 digito )
		push 	dx
		add 	dl,30h
        cmp 	dl,39h
        jle 	termina
        add 	dl,7h
termina:push 	ax
		mov 	ah,02h
        int 	21h
        pop 	ax
        pop 	dx
        ret
        
        
print_2:
		;recibe el dato en dl ( 2 digitos )
		push 	ax
		push 	bx
		push 	dx
		mov 	bl,dl
        and 	bl,0Fh
        shr 	dl,4h
        call 	print_1
        mov 	dl,bl
        call 	print_1
        pop 	dx
        pop 	bx
        pop 	ax
        ret
        
print_4 :
		;recibe el dato en dx ( 4 digitos )
		push 	dx
		mov 	dl,dh
		call 	print_2
		pop 	dx
		call 	print_2
		ret        


salto: 
		push 	ax
		push 	dx
		mov 	dx ,offset back
		mov 	ah,09h
		int 	21h
		pop 	dx
		pop 	ax
		ret

end