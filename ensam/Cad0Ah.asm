.model 	small
.386
extrn 	des2:near
extrn 	spc:near
extrn 	newLine:near
extrn 	hexToDec:near
.stack
.data

tbuf db 5
rbuf db ?
bufer db 5 dup(?);5letras
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
		
		print 	"introduce cadena:"
		mov 	ah,0Ah
		mov 	dx,offset 	tbuf
		int 	21h
		call 	newLine
		mov 	dl,rbuf
		call 	hexToDec
		call 	newLine
		
		mov 	ax,offset 	bufer
		call 	newLine
.exit 0
end