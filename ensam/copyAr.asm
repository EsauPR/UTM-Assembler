;:::::::::::::::::::::::::::::::::::::::::
;:::::::TRANSFERENCIA DE DATOS::::::::::::
;:::::COPIANDO UN ARREGLO A OTRO::::::::::No terminadoooooooooooo
;:::::::::::::::::::::::::::::::::::::::::
.model 	small
extrn 	des2:near
extrn 	spc:near
extrn 	newLine:near
.stack
.data
arreglo		db 		"HOLA$"
arreglo2	db 		"CHAO$"
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
			
		;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
		
		call 	newLine
		mov 	cx,5
		cld 	;autoincremento
		mov 	si,offset arreglo2
		
		ciclo0:
			lodsb 	;carga en AL , e incrementa SI
			mov 	dl,al
			call 	des2
			call 	spc
			loop 	ciclo0
			
		
		;:::::::::::::::::Se copia en el arreglo1 el arreglo2:::::::::::::::::::
		
		call 	newLine
		mov 	cx,5
		cld 	;autoincremento
		mov 	si,offset arreglo2
		
		ciclo1:
			lodsb 	;carga en AL , e incrementa SI
			mov 	arreglo2[cx],al
			loop 	ciclo1
		
			;::::::::::::::::::::::::::::::
		mov 	cx,5
		cld 	;autoincremento
		mov 	si,offset arreglo
		
		ciclo2:
			lodsb 	;carga en AL , e incrementa SI
			mov 	dl,al
			call 	des2
			call 	spc
			loop 	ciclo2
			
		;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
		
		call 	newLine
		mov 	cx,5
		cld 	;autoincremento
		mov 	si,offset arreglo2
		
		ciclo03:
			lodsb 	;carga en AL , e incrementa SI
			mov 	dl,al
			call 	des2
			call 	spc
			loop 	ciclo03
		.exit 0
end