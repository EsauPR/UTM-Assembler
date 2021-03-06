.model small
.386
extrn	print_4:near
extrn	print_2:near
extrn	salto:near
extrn	spc:near
.stack 100
.data
PUERTO	dw	00h
PUERTO2	dw	01h
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
 salta:	pop ds			;etiqueta local de salto, recuperar seg  de datos
	popa			;recuperar registros
endm


main:	mov ax,@data
	mov ds,ax
	mov es,ax
;inicializar puerto 1
	mov ah,00h	;inicializar
	mov al,0e3h	;9600, nopar, 1stop, 8bits
	mov dx,PUERTO	;serial 1 (nullmodem)
	int 14h
;status en ax
	mov dx,ax
	print "inicializacion: "
	call print_4
	call salto

;inicializar puerto 2
	mov ah,00h	;inicializar
	mov al,0e3h	;9600, nopar, 1stop, 8bits
	mov dx,PUERTO2	;serial 1 (nullmodem)
	int 14h
;status en ax
	mov dx,ax
	print "inicializacion: "
	call print_4
	call salto
	
;probar status
	mov dx,PUERTO
	mov ah,03
	int 14h
	mov dx,ax
	print "status: "
	call print_4
	call salto
	
	call pstatus

;esperar hasta recibir
	mov cx,400
 cic:	mov ah,02h	;recibir
	mov dx,PUERTO	;serial 1
	int 14h
	
	cmp ah,0
	jne sig
	
	cmp al,1Bh
	je sale
	mov dl,al
	mov ah,01	;transmitir
	mov dx,PUERTO2	;puerto1 nullmodem
	int 14h
	mov ah,02
	int 21h
	;push ax
	;mov dl,ah	;código devuelto
	;call desp2
	;call salto
	;pop ax
	;mov dl,al	;dato recibido
	;call desp2
	;call spc
	;call spc
	
 sig:	push cx		;retardo
	mov cx,0ffffh
 wai:	loop wai
 	pop cx
 	
	loop cic
	
	
 sale:	mov ah,4Ch
 	int 21h
 	
;;;mostrar status del puerto
pstatus:	mov dx,PUERTO
	mov ah,03
	int 14h
	mov bx,ax
	and bx,1000000000000000b
	jz ps14
	print "Time out error"
	call salto
 ps14:	mov bx,ax
	and bx,0100000000000000b
	jz ps13
	print "Transmitter shift register empty"
	call salto
 ps13:	mov bx,ax
	and bx,0010000000000000b
	jz ps12
	print "Transmitter holding register empty"
	call salto
 ps12:	mov bx,ax
	and bx,0001000000000000b
	jz ps11
	print "Break detection error"
	call salto
 ps11:	mov bx,ax
	and bx,0000100000000000b
	jz ps10
	print "Framing error"
	call salto
 ps10:	mov bx,ax
	and bx,0000010000000000b
	jz ps09
	print "Parity error"
	call salto
 ps09:	mov bx,ax
	and bx,0000001000000000b
	jz ps08
	print "Overrun error"
	call salto
 ps08:	mov bx,ax
	and bx,0000000100000000b
	jz ps07
	print "Data available"
	call salto
 ps07:	mov bx,ax
	and bx,0000000010000000b
	jz ps06
	print "Receive line signal detect"
	call salto
 ps06:	mov bx,ax
	and bx,0000000001000000b
	jz ps05
	print "Ring indicator"
	call salto
 ps05:	mov bx,ax
	and bx,0000000000100000b
	jz ps04
	print "Data set ready (DSR)"
	call salto
 ps04:	mov bx,ax
	and bx,0000000000010000b
	jz ps03
	print "Clear to send (CTS)"
	call salto
 ps03:	mov bx,ax
	and bx,0000000000001000b
	jz ps02
	print "Delta receive line signal detect"
	call salto
 ps02:	mov bx,ax
	and bx,0000000000000100b
	jz ps01
	print "Trailing edge ring detector"
	call salto
 ps01:	mov bx,ax
	and bx,0000000000000010b
	jz ps00
	print "Delta data set ready"
	call salto
 ps00:	mov bx,ax
	and bx,0000000000000001b
	jz pssale
	print "Delta clear to send"
	call salto
 pssale:	ret
end
