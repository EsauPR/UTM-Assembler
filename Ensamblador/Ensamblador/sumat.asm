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

		call suma
		add sp,2

		mov dl,al
		mov dh,0
		call des2

		.exit 0

	suma:
		push bp
		mov bp,sp
		sub sp,2 		;2 variables locales de 16 bits

		mov ax,[bp+4]	;dato1
		cmp al,1
		je sale

		sub al,1
		push ax
		call suma
		add sp,2

		mov bx,[bp+4]
		add al,bl

		mov[bp-2],ax	;usando variable local
		mov ax,[bp-2]	

		mov sp,bp
		pop bp

	sale:
		ret

end