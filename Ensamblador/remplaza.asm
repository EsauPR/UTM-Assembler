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


		mov cx,0Ah
		mov bx,offset arr
	loo1:
		mov dx,[bx]
		mov ah,02h
		int 21h
		call spc
		inc bx
		loop loo1


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
		push bx
		mov bx,di
		dec bx
		mov byte ptr[bx],'#'
		pop bx
		jne et1
	et3:
		call salto
		mov dx,bx
		call print_dec
		print" veces encontrada"
		call salto

		mov cx,0Ah
		mov bx,offset arr
	loo:
		mov dx,[bx]
		mov ah,02h
		int 21h
		call spc
		inc bx
		loop loo

.exit 0

end
