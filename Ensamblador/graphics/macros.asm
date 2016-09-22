.model small
.stack
.code

mrect macro  x1,y1,x2,y2,co
	local loop1,loop2

	mov al,co	;amarillo
	mov ah,0Ch	;funcion escribir punto
	mov dx,y1

	loop1:
	mov cx,x1
		loop2:
		int 10h
		add cx,1
		cmp cx,x2
		jne loop2
	add dx,1
	cmp dx,y2
	jne loop1
endm

main:	;leer configuración de pantalla y guardarla en la pila
	mov ah,0fh
	int 10h
	push ax
	;mov dl,al
	;call desp2

	;mov ax,4f02h
	;mov bx,102h	;800x600,16 colores
	;int 10h

	;definir pantalla 640x480, 16 colores
	mov ah,0
	mov al,12h
	int 10h

	mrect 0 0 40 40 03
	mrect 80 0 120 40 03
	mrect 160 0 200 40 03
	mrect 40 40 80 80 03
	mrect 120 40 160 80 03
	mrect 0 80 40 120 03
	mrect 80 80 120 120 03
	mrect 160 80 200 120 03

	;esperar usuario
	mov ah,00h
	int 16h
	;restaurar pantalla
	pop ax
	mov ah,0
	int 10h
	
fin:	mov ah,4ch
	int 21h
	
;HEX    BIN        COLOR
;0      0000      black
;1      0001      blue
;2      0010      green
;3      0011      cyan
;4      0100      red
;5      0101      magenta
;6      0110      brown
;7      0111      light gray
;8      1000      dark gray
;9      1001      light blue
;A      1010      light green
;B      1011      light cyan
;C      1100      light red
;D      1101      light magenta
;E      1110      yellow
;F      1111      white

end
