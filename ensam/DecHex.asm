.model small
extrn newLine:near
extrn decToHex:near
extrn hexToDec:near
extrn des4:near
.stack
.data
.code

main:
	;lee decimal despliega hex y decimal de nuevo
		;call decToHex
		;call newLine
		;mov dx,ax
		;push dx
		;call des4
		;call newLine
		;call hexToDec
		;pop dx
		call decToHex
		mov cx,ax
		call newLine
		
		call decToHex
		mul cx
		call newLine
		mov dx,ax
		call hexToDec
		
		
		.exit 0
end