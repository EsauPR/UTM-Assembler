.model small
extrn print_dec:near
extrn salto:near
extrn print_4:near
extrn print_1:near
.stack
.data

nombre db 'texto.txt',0h
bufer db 1 dup('$')
fid	dw ?

.code
main:
	mov ax,@data
	mov ds,ax
	mov es,ax

	;abrir archivo -------------------------
	mov al,0
	mov ah,3Dh
	mov dx,offset nombre
	int 21h
	jnc sigue1
	call ferror
	jmp sale
	
sigue1:
	mov fid,ax
	call getByte
	call printByte
	call getByte
	call printByte
	
sale:
	nop
	.exit 0
	
getByte:
	mov bx,fid
	mov ah,3Fh
	mov cx,1
	mov dx,offset bufer
	int 21h
	jnc sigue2
	call ferror
	jmp sale2
  sigue2:
	ret
  sale2:
    .exit 0
	

printByte:
	mov dx,ax	;para numero de letras leidas
	cmp dx,1
	jne s1
	push dx
	mov dl,bufer
	mov ah,02h 
	int 21h
	pop dx
   s1:
	ret
	
	
ferror:
	mov dx,ax
	call print_dec
	call salto
end