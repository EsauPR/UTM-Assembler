.model small
.stack
.data
.code
pletra macro
		mov ah,02h
		int 21h
endm

pletra2 macro letra
		mov dl,letra
		mov ah,02h
		int 21h
endm

print macro cadena
local dbcad,dbfin,salta
		pusha ;respalda todo
		push ds
		mov dx,cs
		mov ds,dx

		mov dx,offset dbcad
		mov ah.09h
		int 21
		jmp salta
	dbcad db cadena
	dbfin db 24h
salta: 
		pop ds
		popa; restaura todo

endm


main:

		mov ax,@data
		mov ds,ax

		mov dl,41h
		pletra

		pletra2 42h

		.exit 0
end