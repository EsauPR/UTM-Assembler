;REPE(repetir mientras sea igual)
;REPNE(repetir mientras no sea igual)
;SCASB---> cmp al,['DI'] 	sale si ya no cumple
;			INC DI
;  			DEC CX
; 			CMP CX,0 		sale si iguales
.model small
.386
extrn lee_2:near
extrn lee_dec:near
extrn print_1:near
extrn print_2:near
extrn salto:near
extrn print_4:near
extrn print_dec:near
extrn show:near
extrn spc:near
.stack
.data
arreglo db  "ABCDEFGHAAIJKA$"
arreglo2 db "BBBBB$"

.code

print macro cadena
local dbcad,dbfin,salta
	pusha	;respalda todo
	push ds	;respalda DS,porque vamos a usar segmento de código
	mov dx,cs	;segmento de código será también de datos
	mov ds,dx
	
	mov dx,offset dbcad ;dirección de cadena(en segmento de código)
	mov ah,09h
	int 21h	;desplegar
	jmp salta ;saltar datos para que no sean ejecutados
dbcad db cadena	;aquí estará la cadena pasada en la sustitución
dbfin db 24h ;fin de cadena
	salta: pop ds ;etiqueta local de salto, recuperar segmento de datos
		   popa	  ;recuperar registros
endm


main: mov ax,@data
	  mov ds,ax
	  mov es,ax
	  
	  
	  ;mov ax,offset arreglo
	  ;m_dm ax,5
	  ;call salto
	  
	  mov di,offset arreglo
	  cld
	  mov cx,14
	  mov bx,0
	  mov al,'A'
	  regresa: repne scasb
	  ;cx:  contado, 
	  ;bandera del 0 indica si hubo igualdad
	  ;push cx
	  je encontro
	  ;print "No encontro"
	  call salto
	  jmp sigue
	encontro:
		inc bx
		;print "Encontro"
		cmp cx,0
		jne regresa
		call salto
	sigue: mov dx,bx
		   ;mov dx,11
		   ;sub dx,cx
		   print"Num Veces encontrada:"
		   call spc 
		   call print_dec
		   call salto
	 
	 
.exit 0

end