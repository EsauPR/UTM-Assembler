.model small
extrn lee2:near
extrn des4:near
extrn newLine:near
.stack
.data
.code

multi macro num1, num2
	mov al,num1
	mov dl,num2
	mul dl

endm

main:

		mov ax,@data
		mov ds,ax

		call lee2
		call newLine
		call newLine
		push ax
		call lee2
		call newLine
		call newLine
		pop dx

		multi al dl
		mov dx,ax

		call des4

		.exit 0
end

