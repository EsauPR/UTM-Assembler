.model small
extrn des1:near
.stack
.data
arreglo db 1,2,3,4
.code

main:
		mov ax,@data
		mov ds,ax
		mov es,ax

		mov cx,04h
		cld ; reinicia banderas
		mov si, offset arreglo
	
	ciclo:
		lodsb ; carga en al e incremente si
		mov dl,al
		call des1
	loop ciclo



		mov cx,04h
		cld ; reinicia banderas
		mov di, offset arreglo
		mov al,0Ah
	ciclo2:
		stosb ; copia en arreglo contenido en al
	loop ciclo2

		;rep stosb =>	mov[d1],al
		;		   =>	inc di
		;		   =>	dec cx
		;		   sale si cx == 0


	
		mov cx,04h
		cld ; reinicia banderas
		mov si, offset arreglo
	
	ciclo3:
		lodsb ; carga en al e incremente si
		mov dl,al
		call des1
	loop ciclo3


		.exit 0
end

