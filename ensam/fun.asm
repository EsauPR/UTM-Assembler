.model 		small
 public 	newLine
 public 	lee1
 public 	des1
 public 	lee2
 public 	des2
 public 	lee4
 public 	des4
 public 	decToHex
 public 	hexToDec
 public 	acarreo
 public 	show
 public 	lee_dec
 public 	spc
.stack
.data
.code


;division larga -> div registroX (   dx y ax ) / registroX -> residuo en dx, resultado ax  ----- ie div cx
;division corta -> div registro rl o rh -> ( ax ) / r    residuo en ah, resultado en al ----- ie div cl
;multiplicacion larga -> ax * rx  = dx ax
;multiplicacion corta -> ax * rl = ax

;imprime acarreo

lee_dec:
		push 	bx
		push 	dx
		push 	cx
		mov 	ax,0 		;inicializa las variables 
		mov 	bx,0
		mov 	cx,0Ah		
		ciclo:
			push 	ax			;respaldo el acomulador
			call 	lee1		;leo el nuevo numero
			mov 	bl,al		; respaldo el nuevo digito
			pop 	ax			;recupero el acomulador
			cmp 	bl,0DDh		; comparo... es enter?
			je 		fin			; si ---> termina
			mul 	cx			;multiplico por A
			add 	ax,bx		;le sumo el nuevo dato
			jmp 	ciclo		
		fin: 
			pop 	cx
			pop 	dx
			pop 	bx
			ret
			
acarreo:
		push 	ax ;respaldando
		push 	dx ;respaldando
		mov 	dl, '1'
		mov 	ah,02h
		int 	21h
		pop 	dx ;restaurando
		pop 	ax ;restaurando
		ret

;Inserta una nueva linea
newLine:
		push ax ;respaldando
		push dx ;respaldando
		mov dl, 0Ah
		mov ah,02h
		int 21h
		pop dx ;restaurando
		pop ax ;restaurando
		ret

spc: 
		push 	ax
		push 	dx
		mov 	dl,20h
		mov 	ah,02h
		int 	21h
		pop 	dx
		pop 	ax	
		ret
		
;Lee un solo digito, lo convierte de sus ASCII a hexadecimal
lee1:	
		mov ah,01h
		int 21h
		sub al,30h
		cmp al,0Fh
		jle next1
		sub al,07h
		cmp al,0Fh
		jle next1
		sub al,20h
		next1:
		ret
;Despliega un digito, lo convierte de hexadecimal a ASCII
des1:
		push ax ;respaldando original
		push dx ;respaldando original
		add dl,30h
		cmp dl,39h
		jle next2
		add dl,07h
		next2:
		mov ah,02h
		int 21h
		pop dx ;restaurando original
		pop ax ;restaurando original
		ret

lee2:
		push bx ;respaldando original
		call lee1
		shl al,04h
		mov bl,al
		call lee1
		add al,bl
		pop bx ;restaurando original
		ret
		
des2:
		push bx ;respaldando original
		push dx ;respaldando original
		mov bl,dl
		and bl,0Fh
		shr dl,04h
		call des1
		mov dl,bl
		call des1
		pop dx ;restaurando original
		pop bx ; restaurando original
		ret
		
lee4:
		push bx ;respaldando original
		call lee2
		push ax
		call lee2
		pop bx
		mov ah,bl
		pop bx ;restaurando original
		ret

des4:
		push dx ;respaldando original
		push dx
		mov dl,dh
		call des2
		pop dx
		call des2
		pop dx ; restaurando original
		ret

decToHex:
		push cx ;respaldando
		push bx ;respaldando
		mov cl,0Ah
		mov ch,0h
		mov bh,0h
		push 0h
	iniDec:
		call lee1
		cmp al,0DDh
		je f1
		mov bl,al
		pop ax
		mul cx
		add ax,bx
		push ax
		cmp bl,0DDh
		je f1
		jmp iniDec		
	f1:
		pop ax
		pop bx ;restaurando
		pop cx ;restaurando
		ret

hexToDec:
		; iniciando respaldo
		push ax
		push bx
		push cx
		push dx
		; fin respaldo
		mov ax,dx
		mov dx,0h
		xor cx,cx
		mov bx,0Ah
	cicloH:
		div bx
		push dx
		add cx,01h
		mov dx,0h
		cmp ax,0h
		je nextH
		jmp cicloH
	nextH:
		pop dx
		call des1
		loop nextH
		;recuperando
		pop dx
		pop cx
		pop bx
		pop ax
		ret

show: 
		push ax
		push bx
		push cx
		push dx
		
		mov dx, ax
		call des4
		call newLine
		
		mov dx,bx
		call des4
		call newLine
		
		mov dx ,cx
		call des4
		call newLine
		
		pop dx
		push dx
		call des4
		call newLine
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret

		
end