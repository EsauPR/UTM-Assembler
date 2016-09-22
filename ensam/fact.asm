.model small
extrn lee2:near
extrn des2:near
extrn newLine:near
extrn hexToDec:near
extrn show:near
.stack
.data
.code
main:
		call lee2
		mov ah,0h
		push ax
		call newLine

		call suma
		add sp,2
		;call show
		mov dx,ax
		call hexToDec
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
		mul bx

		mov[bp-2],ax	;usando variable local
		mov ax,[bp-2]	
	sale:
		mov sp,bp
		pop bp
		ret

end