.model small
extrn lee1:near
extrn lee2:near
extrn des1:near
extrn des2:near
extrn newLine:near
extrn hexToDec:near
extrn show:near
.stack
.data
.code
main:
		call lee1;
		mov ah,0h
		push ax
		push 0Ah
		push 0Bh
		push 0Ch
		call newLine
		call newLine

		;call hanoi
		add sp,8
		.exit 0

	hanoi:
		push bp
		mov bp,sp
		sub sp,8		;2 variables locales de 16 bits

		mov ax,[bp+10]	;n-discos
		sub ax,01h

		cmp ax,0h
		je sale
		
		mov [bp-2], ax
		mov ax,0Ah
		mov [bp-4], ax
		mov ax,0Ch
		mov [bp-6], ax
		mov ax,0Bh
		mov [bp-8], ax

		call hanoi

		mov dx,[bx+4]
		call des1
		mov dx,[bx+8]
		call des1
		call newLine

		mov[bp-2],ax	;usando variable local
		mov ax,[bp-2]	;
	sale:
		mov sp,bp
		pop bp
		ret

end