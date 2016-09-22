.model small
.386
org 100h
.stack

.code
print macro x, y, attrib, sdat
LOCAL   s_dcl, skip_dcl, s_dcl_end
    pusha
    mov dx, cs
    mov es, dx
    mov ah, 13h
    mov al, 1
    mov bh, 0
    mov bl, attrib
    mov cx, offset s_dcl_end - offset s_dcl
    mov dl, x
    mov dh, y
    mov bp, offset s_dcl
    int 10h
    
    mov dx,ds
    mov es,dx
    popa
    jmp skip_dcl
    s_dcl DB sdat
    s_dcl_end DB 0
    skip_dcl:
endm

main:
	print 7,7,00101011b,"H"
	print 8,8,00101011b,"O"
	print 7,9,00101011b,"L"
	print 6,8,00101011b,"A"
	print 1,1,00101011b," "

	mov ah,4Ch
	int 21h
end
	
