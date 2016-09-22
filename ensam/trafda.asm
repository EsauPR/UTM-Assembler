;:::::::TRANSFERENCIA DE DATOS 
.model 	small
extrn 	des2:near
extrn 	spc:near
extrn 	newLine:near
.stack
.data
arreglo	db 		"HOLA$"
.code

main:
		mov 	ax,@data
		mov 	ds,ax
		mov 	es,ax
		
		mov 	cx,5
		cld 	;autoincremento
		mov 	si,offset arreglo
		
		ciclo:
			lodsb 	;carga en AL , e incrementa SI
			mov 	dl,al
			call 	des2
			call 	spc
			loop 	ciclo
			
		;:::::::::::::::::Se copia en el arreglo la letra A:::::::::::::::::::
		
		mov 	cx,5
		cld
		mov 	di,offset arreglo
		mov 	al,'A'
		;ciclo2:
		;	stosb
		;	loop 	ciclo2
		rep		stosb 
		call 	newLine
			
		;:::::::::::::::::Se imprime de nuevo el arreglo::::::::::::::::::::::
		
		mov 	cx,5
		cld 	
		mov 	si,offset arreglo
		ciclo3:
			lodsb 	
			mov 	dl,al
			call 	des2
			call 	spc
			loop 	ciclo3
		.exit 0
end