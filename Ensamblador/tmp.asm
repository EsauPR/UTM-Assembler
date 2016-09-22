.model small 
extrn newLine:near
extrn lee1:near
extrn des1:near
extrn lee2:near
extrn des2:near
extrn lee4:near
extrn des4:near
.stack
.code

main:
	
		call lee4
		mov dx,ax
		call newline
		call des4

		.exit 0
end
