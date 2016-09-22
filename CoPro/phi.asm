.model small
.386
extrn	fdstackf:near
extrn	fdstacki:near
extrn	fdespbcd:near
extrn	fdespflo:near
extrn	fleebcd:near
extrn	print_2:near
extrn	print_1:near
extrn	print_4:near
extrn	salto:near
extrn	spc:near
extrn	lee_dec:near
.stack
.data

FBCDt	dt	0h
RESUL	dd	?
phi		dd ?
cuatro	dd 4.000
cero	dd 0.000
dos		dd 2.000
uno     dd 1.000
flagdsp	db	0

STWD	dw	?

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

;-------MACROS------------
clear_screen macro
	pusha
	mov ax, 0600h
	mov bh, 00001111b
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	popa
endm
print	macro cadena
local dbcad,dbfin,salta
	pusha			;respalda todo
	push ds			;respalda DS, porque vamos a usar segmento de código
	mov dx,cs		;segmento de código será también de datos
	mov ds,dx
	
	mov dx,offset dbcad	;dirección de cadena (en segmento de código)
	mov ah,09h
	int 21h			;desplegar
	jmp salta		;saltar datos para que no sean ejecutados
	dbcad db cadena		;aquí estará la cadena pasada en la sustitución
	dbfin db 24h		;fin de cadena
salta:	pop ds			;etiqueta local de salto, recuperar segmento de datos
	popa			;recuperar registros
endm
;-------------------------
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	
	finit 	;Reseteo al coprocesador por si hay basura
	
	;call fdstackf

	print "Introduce num de iteraciones"
	call salto
	call lee_dec
	call salto
	mov dx,ax
	mov cx,ax
	call print_4
	call salto
	;mov dx,offset FBCDt
	;call fleebcd	;poner en FBCDt (apuntado por DX)
	
	fld cero

	ciclo: 
	
	mov dx,cx
	print "CX: "
	call print_4
	call salto
	
	fld cuatro
	fld uno	
	
	fst phi
	mov dx,offset phi
	call fdespflo
	
	call salto
	;call fdstackf
	fdiv
	;call fdstackf
	;Aqui va saber si es suma o resta
	mov ax,cx
	push bx
	mov bl,2
	div bl
	pop bx
	mov dl,ah
	call print_2
	call salto
	cmp ah,0
	je resta
	fadd 
	print "CX: "
	jmp salta
	
	resta: fsub
	
	salta:
	fst phi
	mov dx,offset phi
	call fdespflo

	
	;call fdstackf
	;incremetar uno en dos
	fld uno
	fld dos
	fadd
	fstp uno ;aqui ya tengo la secuencia impar
	
	;loop ciclo
	dec cx
	jnz ciclo
	
	
	
	
	
	
	
	print "Resultado: "
	fst RESUL	
	mov dx,offset RESUL
	call fdespflo
	
	.exit 0
	
end