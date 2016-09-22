.model small
.386
.387
extrn fdespflo:near
extrn reto:near
extrn fleebcd:near
extrn fdespbcd:near
extrn fdstackf:near
extrn desp4:near

.stack
.data
NUM1	dd	3.0	;4 B
NUM2	dd	3.0	;4 B
ESTADO	dw	?
.code
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


main:	mov ax,@data
	mov ds,ax
	mov es,ax
	
	fld NUM1	;Carga en la pila
	fld NUM2
	 call fdstackf
	 call reto
	fcompp		;Compara y afecta registro de estado
	;fstsw ax
	fstsw ax	;Copiar registro de estado a AX
	 call fdstackf
	 call reto
	fwait		;Esperar a que terminen operaciones
	mov ESTADO,ax	;Copiar a variable
	mov dx,ax
	call desp4
	call reto
	
	mov ax,ESTADO
	and ax,4500h
	mov ESTADO,ax
	
	mov dx,ax
	call desp4
	call reto

	mov ax,ESTADO
	cmp ax,0
	jne sig1
	print "mayor"
	jmp sale
 sig1:	mov ax,ESTADO
 	cmp ax,100h
	jne sig2
	print "menor"
	jmp sale
 sig2:	print "iguales"
 
 sale:	.exit 0
end
