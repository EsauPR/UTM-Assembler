.model small
extrn newLine:near
extrn decToHex:near
extrn hexToDec:near
extrn des4:near
.stack
.data
.code

main:
		mov 	ax,@data
		mov 	ds,ax
		
		;voy a llamr a una funcion
		;el parametro lo pngo en la pila
		
		mov 	ax,05h
		push 	ax
		call 	fun
		add 	sp,02
		call 	des4
		
		fun:	
			;recibia datos en DL
			;ahora usara la pila
			;pila:ret,dato1
			;BP:es la base que utiliza una funcion
			;para acceder a parametros y var locales
			;cada funcion tiene un valor de BP
			push bp ;respaldo BP de funcion anterior
			;pila:BP0,ret,dato1
			mov bp,sp	;nuevo BP,estatico para la funcion
			;aqui se reserva espacio en la pila para var locales
			
			;------------------------
			mov ax,[bp+4]  ;localizacion del ultimo parametro
			inc ax
			
			
			;------------------------	
			
			;retaurar espacio de variables locales
			pop bp
			
			ret		
		
		.exit 0
end