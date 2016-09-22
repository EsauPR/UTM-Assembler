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
tbuf db 5
rbuf db ?
bufer db 5 dup(?)
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


m_dm macro reg

endm

main:	mov ax,@data
		mov ds,ax
		mov es,ax

		print "Introduce Cadena: "
		mov dx, offset tbuf
		mov ah,0Ah
		int 21h
		call salto
		mov dl,rbuf
		call print_dec

		mov ax,offset bufer
		m_dm ax,5
		call salto

.exit 0

end