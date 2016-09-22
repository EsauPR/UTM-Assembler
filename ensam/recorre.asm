;:::::::::::::::::::::::::::::::::::::::::
;:::::::TRANSFERENCIA DE DATOS::::::::::::
;:::::::::RECORRE UN ARREGLO::::::::::::::
;:::::::::::::::::::::::::::::::::::::::::

.model 	small
.386
extrn 	des2:near
extrn 	spc:near
extrn 	newLine:near
extrn 	hexToDec:near
.stack
.data
arreglo	db	"GeovanniVentura$"
.code

print 	macro 	cadena
		local 	dbcad,dbfin,salta
		pusha
		push 	ds
		mov 	dx,cs
		mov 	ds,dx
		mov 	dx,offset 	dbcad
		mov 	ah,09h
		int 	21h
		jmp 	salta
		dbcad 	db 	cadena
		dbfin 	db 	24h
		salta:
				pop ds
				popa
		
endm

main:
		mov 	ax,@data
		mov 	ds,ax
		mov 	es,ax
		
		mov 	ax,offset arreglo
		call 	newLine
		
		mov 	di,offset arreglo
		cld
		mov 	cx,16
		mov 	al,'V'
		repne 	scasb
		;cx contador, bandera del 0 indica si hubo igualdad
		push 	cx
		je 		encontro
		print 	"No encontro"
		call 	newLine
		jmp 	sigue
		encontro:
				print 	"Encontro"
				call 	newLine
		sigue:
				pop 	cx
				mov 	dx,15
				sub 	dx,cx
				call 	hexToDec
				call 	newLine
		.exit 0
	
end