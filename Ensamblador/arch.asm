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
nombre db  "nombre.txt",0h
bufer db  80 dup(24h)
fid dw ?
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


main:	mov ax,@data
		mov ds,ax
		mov es,ax

		mov al,0
		mov ah,3Dh
		mov dx,offset nombre
		int 21h
		jnc sigue1
		call ferror
		jmp sale

	sigue1:
		mov fid,ax
		mov dx,ax
		call print_4
		call salto
		;leer del archivo abierto
		mov bx,fid
		mov ah,3Fh ;leer archivo
		mov cx,80
		mov dx,offset bufer
		int 21h
		jnc sigue2
		call ferror
		jmp sale

	sigue2:
		mov dx,ax
		call print_dec
		call salto
		mov dx,offset bufer
		mov ah,09h
		int 21h

	sale:
		nop
		.exit 0

ferror: print "Error: "
		mov dx,ax
		call print_4
		call salto
		ret

end
