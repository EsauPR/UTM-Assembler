;Versión 1.1
; 1.1	Los números se teclean directo.
; 1.0	Funcional, pero sólo con la suma. Requiere un <enter> para proceder
;	a teclear un número.
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
;extrn	hexdum:near
;extrn	lee1_ne:near
.stack
.data

FBCDt	dt	0h
RESUL	dd	?

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
	
	repite:
	repit: 

	print "Introduce un numero"
	call salto
	mov dx,offset FBCDt
	call fleebcd	;poner en FBCDt (apuntado por DX)
	fbld FBCDt		;cargalo a la pila
	call fdstackf	;desplegar pila como flotantes
	;mov dl,al
	;call print_4
	
	cmp al,02Bh ;suma
	jne sig	
	fadd
	print "Suma: "
	jmp repites
		
sig:	cmp al,02Dh ;Resta
	jne	sig1
	fsub
	print "Resta: "
	jmp repites
	
sig1:	cmp al,02fh ;Div
	jne	sig2
	fdiv
	jmp repites
	
sig2:	cmp al,02ah	;Mul
	jne	sig3
	fmul
	jmp repites
	
sig3:	;cmp al,0dh	;enter
	;je repit
	

	
	cmp al,01bh ;esc
	je fin
	
	repites: 
	call salto
	
	call fdstackf
	;call salto
	;print "Res"
	;fstp RESUL	
	;mov dx,offset RESUL
	;call fdespflo
	;call salto
	;jmp repite
	call repite

	fin:.exit 0
	
end