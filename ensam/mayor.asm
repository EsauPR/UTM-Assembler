;:::::::::::::::::::::::::::::::::::::::::::
;::::::TRANSFERENCIA DE DEATOS MACRO::::::::
;:::::::::::::::::::::::::::::::::::::::::::
.model 	small
extrn 	lee2:near
extrn 	lee_dec:near
extrn 	newLine:near
extrn 	hexToDec:near
extrn 	spc:near
.stack
.data
.code

mmayor1	macro 	num1,num2,resu
		
		local 	resultado,salto1,salto2
		push 	ax
		push 	bx
		push 	cx
		push 	dx
		
		resultado 	db 	00h,00h,00h,00h
		;mov al,num1
		mov 	resultado[0],num1
		mov 	resultado[1],num2
		mov 	resultado[2],resu
		mov 	al,resultado[0]
		mov 	bl,resultado[1]
		cmp 	al,bl
		jge 	salto1
		;es menor
		mov 	resultado[2],bl
		jmp 	salto2
		salto1: 
				mov 	resultado[2],al
		salto2: 
				pop 	dx
				pop 	cx
				pop 	bx
				pop 	ax
				mov	 	resu,resultado[2]
endm
main: 
		mov 	ax,@data
	  	mov 	ds,ax
	  	call 	lee_dec
		mov 	bl,al
		call 	newLine		  
		call 	lee_dec
		call 	newLine
		call 	spc
		;------------------------ 
		mmayor1 al bl cl ;Llamo al macro
		;call spc
		mov 	dx,cx
		call 	hexToDec
		;------------------------ 
		call 	newLine 
		mmayor1 al bl al ;Llamo al macro
		;call spc
		mov 	dx,ax
		call 	hexToDec
		;------------------------ 
		call 	newLine 
		mmayor1 al bl dl ;Llamo al macro
	    ;call spc
		mov 	dx,ax
		call 	hexToDec
		;------------------------ 
		call 	newLine 
		mmayor1 al bl bl ;Llamo al macro
		;call spc
		mov 	dx,ax
		call 	hexToDec
.exit 0
end