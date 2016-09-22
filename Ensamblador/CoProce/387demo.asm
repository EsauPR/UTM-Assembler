; fsave FMSVE
; frstor FMSVE

;Versi�n 1.1
; 1.1	Los n�meros se teclean directo.
; 1.0	Funcional, pero s�lo con la suma. Requiere un <enter> para proceder
;	a teclear un n�mero.
.model small
.386
extrn	fdstackf:near
extrn	fdstacki:near
extrn	fdespbcd:near
extrn	fdespflo:near
extrn	fleebcd:near
extrn	newLine:near
.stack
.data

FBCDt	dt	0h
RESUL	dd	?

flagdsp	db	0

STWD	dw	?

.code
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
	push ds			;respalda DS, porque vamos a usar segmento de c�digo
	mov dx,cs		;segmento de c�digo ser� tambi�n de datos
	mov ds,dx
	
	mov dx,offset dbcad	;direcci�n de cadena (en segmento de c�digo)
	mov ah,09h
	int 21h			;desplegar
	jmp salta		;saltar datos para que no sean ejecutados
	dbcad db cadena		;aqu� estar� la cadena pasada en la sustituci�n
	dbfin db 24h		;fin de cadena
salta:	pop ds			;etiqueta local de salto, recuperar segmento de datos
	popa			;recuperar registros
endm
;-------------------------
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	
	finit
	print "Introduce un numero"
	call newLine
	mov dx,offset FBCDt
	call fleebcd	;poner en FBCDt (apuntado por DX)
	fbld FBCDt		;cargalo a la pila
	call fdstackf	;desplegar pila como flotantes
	print "Introduce otro numero"
	call newLine
	mov dx,offset FBCDt
	call fleebcd
	fbld FBCDt
	call fdstackf
	
	fadd
	call fdstackf
	
	print "Suma"
	call newLine
	
	fstp RESUL	
	mov dx,offset RESUL
	call fdespflo
	call newLine
	.exit 0
	
end



