.model 	small
extrn 	newLine:	near
extrn 	decToHex:	near
extrn 	hexToDec:	near
extrn 	des4:		near
extrn 	des2:		near
extrn 	lee2:		near
.stack
.data
.code

main:
		mov 	ax,@data
		mov 	ds,ax

		call 	lee2		;dato en AL
		push 	ax			;DATO 1
		call	lee2
		push	ax			;DATO2
		
		call	suma		;RESULTADO EN AL
		add 	sp,4
		
		mov 	dl,al
		call 	des2
		.exit 0
		
		
		suma:	
			push 	bp 
			mov 	bp,sp	
			sub 	sp,4		;dos variable locales de 16 bits
			
			mov 	ax,[bp+4]  	;DATO 2
			mov 	bx,[bp+6]  	;DATO 1
			add 	al,bl
			mov 	[bp-2],ax	;var local 1
			mov 	ax,[bp-2]
			
			;add sp,4 restaurar espacio variable local
			mov 	sp,bp
			pop 	bp
			ret		
end