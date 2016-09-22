.model small
extrn	des4:near
extrn	des2:near
extrn	newLine:near
.stack 100
.data
PUERTO	dw	00h
.code

main:	mov ax,@data
	mov ds,ax
	mov es,ax

	mov ah,00h	;inicializar
	mov al,0e3h
	;111	00	0	11
	;9600	nopar	1 stop	8bits
	mov dx,PUERTO
	int 14h
	mov dx,ax
	call des4
	call newLine
	call newLine
	
	mov cx,08
	
	mov al,'A'
 ciclo:	push cx
 	mov ah,01	;transmitir
	mov dx,PUERTO	;puerto1 nullmodem
	int 14h
	mov dx,ax
	call des4
	call newLine
	inc al
	
	mov cx,0ffffh	;retardador
 wai:	loop wai
	
	pop cx
	loop ciclo

	;enviar símbolo 'esc' para terminar
	mov ah,01
	mov dx,PUERTO
	mov al,1Bh
	int 14h
		
 sale:	mov ah,4ch
	int 21h

end