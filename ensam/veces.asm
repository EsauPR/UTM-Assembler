;REPE(repetir mientras sea igual)
;REPNE(repetir mientras no sea igual)
;SCASB---> cmp al,['DI'] 	sale si ya no cumple
;			INC DI
;  			DEC CX
; 			CMP CX,0 		sale si iguales
.model 	small
.386
extrn 	newLine:near
extrn 	hexToDec:near
extrn 	spc:near
.stack
.data

arreglo 	db 	"BCABCBCABC$"

.code
print 	macro 	cadena
		local 	dbcad,dbfin,salta
		pusha			;respalda todo
		push 	ds		;respalda DS,porque vamos a usar segmento de código
		mov 	dx,cs	;segmento de código será también de datos
		mov 	ds,dx
	
		mov 	dx,offset 	dbcad 	;dirección de cadena(en segmento de código)
		mov 	ah,09h
		int 	21h					;desplegar
		jmp 	salta 				;saltar datos para que no sean ejecutados
		dbcad 	db 	cadena			;aquí estará la cadena pasada en la sustitución
		dbfin 	db 	24h 			;fin de cadena
		salta: 
				pop 	ds 			;etiqueta local de salto, recuperar segmento de datos
		  		popa	 			;recuperar registros
endm


main: 
		mov 	ax,@data
	  	mov 	ds,ax
	  	mov 	es,ax
		  
		mov 	di,offset arreglo
		cld
		mov 	cx,11
		mov 	bx,0
		mov 	al,'A'
	  	regresa: 
	  			repne 	scasb
			  	je 		encontro
			  	call 	newLine
			  	jmp 	sigue
		encontro:
				inc 	bx
				cmp 	cx,0
				jne 	regresa
				call 	newLine
		sigue: 
				mov 	dx,bx
		  		print	"Numero de veces que encontro la letra :"
		   		call 	spc 
		   		call 	hexToDec
		   		call 	newLine
		.exit 0
end