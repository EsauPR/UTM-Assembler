.model small
extrn print_4:near
extrn salto:near
extrn spc:near 
extrn print_dec:near
.stack
.data
ndir	db	164 dup(0)
comod	db	"*.txt",0
DTA	db	21 dup(0)
attr	db	0
time	dw	0
date	dw	0
sizel	dw	0
sizeh	dw	0
fname	db	13 dup(0)

.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	
	mov dl,0		;unidad actual
	mov si,offset ndir	;ds:si buffer
	mov ah,47h		;LEER DIRECTORIO ACTUAL
	int 21h
	jc erro
	;desplegar directorio actual
	push offset ndir
	call despc
	add sp,02
	call salto
	
	
	;cambiar posicion de DTA
	mov ah,1Ah
	mov dx,offset DTA
	int 21h
	
	;Preparar lectura de directorio y mostra primer archivo
	mov dx,offset comod	;cadena nombre ( *.* )
	mov cx,0		;archivo normal
	mov ah,4Eh		;BUSCAR PRIMER ARCHIVO QUE CUMPLA PATRÓN
	int 21h
	
	call dndta		;desplegar nombre de archivo
	call dtdta
	call salto
	;Mostrar el resto de los archivos
 nf:	
 	mov ah,4Fh
	int 21h
	jc sale
	call dndta
	call dtdta
	call salto
	jmp nf
	
 erro:	mov dx,ax
 	call print_4
 	call salto
	
 sale:	
	
	call salto
	call salto
	.exit 0
	
	
dtdta:
	mov dx,sizeh
	call print_4
	mov dx,sizel
	call print_4
	call spc
	mov dx,sizel
	call print_dec
	ret
	
	;desplegar nombre de archivo en DTA
dndta:	
	push offset fname
	call despc
	add sp,02h
	call spc
	ret	

	;despliega cadena terminada con 0, dir en pila
despc:	push bp
	mov bp,sp
	mov ah,02h
	cld
	mov si,[bp+4]
 dcl:	lodsb	;carga en AL, incrementa SI
	cmp al,0
	je dcs
	mov dl,al
	int 21h
	jmp dcl
 dcs:	pop bp
 	ret
end
	
	