.model small
.stack
.code
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

	;desplegar algo
	mov al,0Eh	;amarillo
	mov ah,0Ch	;funcion escribir punto
	mov cx,0200
	mov dx,0280
	int 10h
	
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