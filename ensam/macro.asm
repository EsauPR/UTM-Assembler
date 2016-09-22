.model small
.stack
.data
.code
pletra 	macro	letra
		mov dl,letra
		mov ah,02h
		int 21h
endm
;:::::::::::::::OTRA::::::::::::::::::
print 	macro 	cadena
	local 	dbcad,dbfin,salta
	pusha						;respalda todo
	push 	ds					;respalda DS,porque vamos a usar segmento de código
	mov 	dx,cs				;segmento de código será también de datos
	mov 	ds,dx
	
	mov 	dx,offset 	dbcad 	;dirección de cadena(en segmento de código)
	mov 	ah,09h
	int 	21h					;desplegar
	jmp 	salta 				;saltar datos para que no sean ejecutados
	dbcad 	db 		cadena		;aquí estará la cadena pasada en la sustitución
	dbfin 	db 		24h 		;fin de cadena
	salta: 
		pop 	ds 				;etiqueta local de salto, recuperar segmento de datos
		popa	  				;recuperar registros
endm
;:::::::::::::::::::::::::::::::::::::::
main:
		mov ax,@data
		mov ds,ax
		
		pletra	41h
		
		mov al,42h
		pletra	al
		.exit 0
end

