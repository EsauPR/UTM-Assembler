.model small
.stack
.data
.code
pletra macro
		mov ah,02h
		int 21h
endm

main:

		mov ax,@data
		mov ds,ax

		mov dl,41h
		pletra

end