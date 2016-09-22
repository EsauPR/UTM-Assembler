.model small
.stack
.data ;solo para almacenamiento de datos
cadena db 'ingresa la cantidad$'
nombre db 0dh,0ah,'Geovanni$'
.code
main: 
	;para colocar el segmento de datos
	mov ax,@data
	mov ds,ax
	;asignacion de la cadena como el 'e' de editar en el debug
	mov dx,offset cadena 
	mov ah,09h ;imprime cadena
	;diversas funcions dependiendo de la instruccion anterior
	int 21h 
	mov ah,01h ;leer caracter
	int 21h
	
	sub al,30h ;resta para convertir a hexadecimal el numero ingresado
	
	cmp al,0fh
	JLE continua
	sub al,7h
	
	cmp al,0fh
	JLE continua
	sub al,20h
	
	continua:	
		mov cl,al ;se cambia a cl->contador
		mov ch,0 ;se completa con un 0 
		
	;compara y salta al final
	cmp cx,0h
	JE termina
		
	vuelta:;inicia ciclo
		mov dx,
		mov ah,02h
		int 21h
	loop vuelta ;terminA cliclo
	
	termina: 
		;Terminar programa
		mov ah,4ch
		int 21h
end