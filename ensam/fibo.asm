.model small
extrn lee2:near
extrn des2:near
extrn newLine:near
extrn hexToDec:near
extrn show:near
extrn lee_dec:near
.stack
.data
.code
main:
		call lee_dec
		mov ah,0h
		push ax
		call newLine
		call fibo
		add sp,2
		;call show
		mov dx,ax
		call hexToDec
		;call decto
		.exit 0

	fibo:
		push bp
		mov bp,sp
		sub sp,2 		;2 variables locales de 16 bits

		mov ax,[bp+4]	;dato1
		cmp al,2
		je sale2
		jl sale
		
		sub 	al,1
		push 	ax
		call 	fibo
		add 	sp,2

		mov 	[bp-2],ax
		
		mov 	ax,[bp+4]
		sub 	al,2
		push 	ax
		call 	fibo
		add 	sp,2
		
		mov 	bx,[bp-2]
		add 	ax,bx

		
		
	sale:
		mov 	sp,bp
		pop 	bp
		ret
		
	sale2:
		mov 	ax,01
		mov 	sp,bp
		pop 	bp
		ret

end