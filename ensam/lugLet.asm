;:::::::::::::::::::::::::::::::::::::::::
;:::::::TRANSFERENCIA DE DATOS::::::::::::
;:::::::::RECORRE UN ARREGLO completo buscando letras::::::::::::::
;:::::::::::::::::::::::::::::::::::::::::
.model small
.386
extrn newLine:near
extrn hexToDec:near
extrn spc:near
.stack
.data
arr 	db	"AAAAAAAAAAAAAAA$"
.code

print 	macro 	cadena
		local dbcad,dbfin,salta
		pusha				;respalda todo
		push 	ds			;respalda DS,porque vamos a usar segmento de código
		mov 	dx,cs		;segmento de código será también de datos
		mov 	ds,dx
		
		mov 	dx,offset 	dbcad 	;dirección de cadena(en segmento de código)
		mov 	ah,09h
		int 	21h					;desplegar
		jmp 	salta 				;saltar datos para que no sean ejecutados
		dbcad 	db 	cadena			;aquí estará la cadena pasada en la sustitución
		dbfin 	db 	24h 			;fin de cadena
		salta: 
				pop 	ds 			;etiqueta local de salto, recuperar segmento de datos
			   	popa	  			;recuperar registros
endm


main:	mov 	ax,@data
		mov 	ds,ax
		mov 	es,ax

		mov 	di,offset 	arr
		cld
		mov 	cx,0Fh
		mov 	al,'A'
		xor 	bx,bx
	et1:
		repne 	scasb
		je 		et2
		jmp 	et3
	et2:
		inc 	bx

		push 	ax
		push 	bx
		push 	cx
		mov 	dx,0Fh
		sub 	dx,cx
		
		call 	hexToDec
		call 	newLine
		pop 	cx
		pop 	bx
		pop 	ax
		
		cmp 	cx,0
		jne 	et1
	et3:
		call 	newLine
		mov 	dx,bx

			print	" Numero de veces encontrada la letra en la cadena:"
			call 	spc
			call 	hexToDec
			call 	newLine
	.exit 0

end