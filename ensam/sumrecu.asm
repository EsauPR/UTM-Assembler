.model small
extrn newLine:near
extrn decToHex:near
extrn hexToDec:near
extrn des4:near
extrn des2:near
extrn lee2:near
.stack
.data
.code

main:
		mov 	ax,@data
		mov 	ds,ax

		call 	lee2		;dato en AL
		push 	ax			;DATO 1
		
		call	sumrec		;RESULTADO EN AL
		add 	sp,2
		
		mov 	dl,al
		call 	des2
		.exit 0
		
		
		sumrec:	
			push 	bp 
			mov 	bp,sp	
			sub 	sp,2		;dos variable locales de 16 bits
			
			mov 	ax,[bp+4]  	;DATO 1
			
			cmp 	al,1
			je 		sale
			
			sub 	al,1			
			push 	ax
			call 	sumrec
			add		sp,2
			
			mov 	bx,[bp+4]
			add		al,bl
			
			mov 	[bp-2],ax	
			mov 	ax,[bp-2]
			
			sale:
				mov 	sp,bp
				pop 	bp
				ret		
end