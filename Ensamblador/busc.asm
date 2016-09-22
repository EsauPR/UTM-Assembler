.model small
extrn newLine:near
extrn des1:near
.stack
.data
arr1	db "ABCDEFGHIJKL"
arr2	db "CHAOS"
.code
main:	mov ax,@data
		mov ds,ax
		mov es,ax



		mov dl,offset arr1
		cld
		mov cx,12
		mov al,'D'
		repne scasb
		;cx contador, dandera del 0 indica si hubo igualdad
		push cx
		je encontro
		
		mov dx,0Bh
		call des1

		call newLine
		jmp sigue
	encontro:
		mov dx,0Ch
		call des1
		call newLine

	sigue:
		pop dx
		call des1
		call newLine



		.exit 0
end
