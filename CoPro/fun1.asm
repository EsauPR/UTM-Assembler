.model small
public carrie
public print_neg
public menos
public lee_1
public lee_2
public lee_4
public print_1
public print_2
public print_4
public salto
public show
public lee_dec
public print_dec
public spc


.stack
.data
back db 0dh,0ah,24h
uno db '1',24h
guion db '-',24h   
datos db 0FFh,0FFh,0FFh,0FFh  
datos2 db 00h,00h,00h,02h
result db 00h,00h,00h,00h 
.code


carrie:
		push ax
		push dx
		mov dx ,offset uno
 		mov ah,09h
		int 21h
		pop dx
		pop ax
		ret

menos:
		push ax
		push dx
		mov dx ,offset guion
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
		

show: 	push ax
		push bx
		push cx
		push dx
		
		mov dx, ax
		call print_4
		call salto
		
		mov dx,bx
		call print_4
		call salto
		
		mov dx ,cx
		call print_4
		call salto
		
		pop dx
		push dx
		call print_4
		call salto
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		
lee_dec:
		push bx
		push dx
		push cx
		mov ax,0 		;inicializa las variables 
		mov bx,0
		mov cx,0Ah		
		ciclo:
		push ax			;respaldo el acomulador
		call lee_1		;leo el nuevo numero
		mov bl,al		; respaldo el nuevo digito
		pop ax			;recupero el acomulador
		cmp bl,0DDh		; comparo... es enter?
		je fin			; si ---> termina
		mul cx			;multiplico por A
		add ax,bx		;le sumo el nuevo dato
		jmp ciclo		
		fin: 
		pop cx
		pop dx
		pop bx
		ret 			;retorna el valor Hexadecimal en AX
print_dec:
		push cx
		push bx
		push dx
		push ax
		mov ax,dx
		mov bx,0Ah
		mov cx,0
		mov dx,0
cicl:
		mov dx,0
		div bx 			; dividimos entre 0Ah
		push dx			;guardamos el residuo en la pila
		inc cx				;aumentamos en 1 el contador de la pila	
		cmp ax,0		; el cociente es cero?
		jne cicl 		; no.... vuelve el ciclo
continua:	
		pop dx			; si.... comineza a sacar de la pila 
		call print_1
		loop continua
		pop ax
		pop dx
		pop bx
		pop cx
		ret
		
print_neg:
		push bx
		push cx
		push ax
		mov bx,dx
		and bx,8000h
		cmp bx,0
		je term
		call menos
		not dx
		inc dx
term:
		call print_4
		pop ax
		pop cx
		pop bx
		ret
		
spc: push ax
	 push dx
	 mov dl,20h
	 mov ah,02h
	 int 21h
	 pop dx
	 pop ax	
	 ret
		
end