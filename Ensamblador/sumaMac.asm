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

main:

		mov ax,@data
		mov ds,ax

		mov dl,41h
		pletra

		pletra2 42h

		.exit 0
end