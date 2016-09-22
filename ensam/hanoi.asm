.model 	small
extrn 	lee2:near
extrn 	des2:near
extrn 	newLine:near
extrn 	hexToDec:near
extrn 	show:near
extrn 	spc:near
.stack
.data
.code
main:
		call 	lee2
		mov 	ah,0h
		push 	ax
		push 	1h
		push	3h
		push	2h
		call 	newLine
		call 	hanoi
		add 	sp,10
		mov 	dx,ax
		.exit 0
		
	hanoi:
		push 	bp
		mov 	bp,sp
		sub 	sp,10 		
		
		mov 	ax,[bp+10]
		cmp 	al,1
		je 		sale2	
		sub 	al,1
		push 	ax
		push 	[bp+8]
		push 	[bp+4]
		push 	[bp+6]
		call 	hanoi
		add 	sp,10
		mov 	dx,[bp+8]
		call 	hexToDec
		call 	spc
		mov 	dx,[bp+6]
		call 	hexToDec
		call 	newLine
		
		mov 	ax,[bp+10]
		sub 	al,1
		push 	ax
		push 	[bp+4]
		push 	[bp+6]
		push 	[bp+8]
		call 	hanoi
		add 	sp,10		
	sale:
		mov 	sp,bp
		pop 	bp
		ret
	sale2:		
		mov 	dx,[bp+8]
		call 	hexToDec
		call 	spc
		mov 	dx,[bp+6]
		call 	hexToDec
		call 	newLine
		mov 	sp,bp
		pop 	bp
		ret
end