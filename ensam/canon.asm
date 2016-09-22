.model small
.stack
.data
cadena db 'Hola Mundo$'
.code
main: mov ax,@data
	mov ds,ax
	mov dx,offset cadena
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h
end