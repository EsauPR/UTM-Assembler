.model small
extrn newLine:near
extrn decToHex:near
extrn hexToDec:near
extrn des4:near
.stack
.data
.code

main:
	
		call decToHex
		call newLine
		mov dx,ax
		call des4
		call newLine
		call hexToDec
		
		.exit 0
end