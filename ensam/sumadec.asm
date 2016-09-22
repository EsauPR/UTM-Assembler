.model small
extrn newLine:near
extrn decToHex:near
extrn des4:near
.stack
.data
.code

main:
	
		call decToHex
		call newLine
		push bx
		mov bx,ax
		call decToHex
		call newLine
		add ax,bx
		mov bx,ax
		pop bx
		jnc continua
		push ax
		mov dl,'1'	
		mov ah,02h
		int 21h
		pop ax
		continua:
			call des4
	
		.exit 0
end