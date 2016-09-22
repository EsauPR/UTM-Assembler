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
arr db  "BCABCBCABC"
.code

print macro cadena
local dbcad,dbfin,salta
	pusha	;respalda todo
	push ds	;respalda DS,porque vamos a usar segmento de c�digo
	mov dx,cs	;segmento de c�digo ser� tambi�n de datos
	mov ds,dx
	
	mov dx,offset dbcad ;direcci�n de cadena(en segmento de c�digo)
	mov ah,09h
	int 21h	;desplegar
	jmp salta ;saltar datos para que no sean ejecutados
dbcad db cadena	;aqu� estar� la cadena pasada en la sustituci�n
dbfin db 24h ;fin de cadena
	salta: pop ds ;etiqueta local de salto, recuperar segmento de datos
		   popa	  ;recuperar registros
endm


main:	mov ax,@data
		mov ds,ax
		mov es,ax

		mov di,offset arr
		cld
		mov cx,10
		mov al,'A'
		xor bx,bx
	et1:
		repne scasb
		je et2
		jmp et3
	et2:
		inc bx
		cmp cx,0
		jne et1
	et3:
		call salto
		mov dx,bx
		call print_dec
		print" veces encontrada"
		call salto
.exit 0

end