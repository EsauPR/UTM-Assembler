.model small
extrn lee2:near
extrn des2:near
extrn newLine:near
.stack
.data
.code

main:

		call lee2
		push ax
		call newLine

		call lee2
		push ax
		call newLine

		call suma
		add sp,4

		mov dl,al
		call des2

		.exit 0

	suma:
		push bp
		mov bp,sp
		sub sp,4 		;2 variables locales de 16 bits

		mov ax,[bp+4]	;dato2
		mov bx,[bp+6]	;dato1
		add al,bl
		mov [bp-2],ax	;moviendo variable local

		mov sp,bp ;add sp,4
		pop bp
		ret

end