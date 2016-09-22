.model small
extrn lee2:near
extrn des2:near
extrn des4:near
extrn newLine:near
extrn hexToDec:near
extrn show:near
extrn decToHex:near
.stack
.data
.code
main:
		call decToHex
		;mov ah,0h

		push ax

		call newLine
		mov dx,ax
		call des4
		call newLine
		
		call suma
		add sp,2
		call show
		;mov dx,ax
		;call hexToDec
		.exit 0

	suma:
		push bp
		mov bp,sp
		sub sp,2 		;2 variables locales de 16 bits

		mov ax,[bp+4]	;dato1
		cmp al,2
		je sale2

		sub al,1
		push ax
		call suma
		add sp,2

		mov[bp-2],ax

		mov ax,[bp+4]
		sub al,2
		push ax
		call suma
		add sp,2

		mov bx,[bp-2]
		add ax,bx

		mov[bp-2],ax	;usando variable local
		mov ax,[bp-2]
	sale:
		mov sp,bp
		pop bp
		ret
	sale2:
		mov ax,01h
		mov sp,bp
		pop bp
		ret

end