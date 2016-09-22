.model small
extrn carrie: near
extrn menos: near
extrn lee_1: near
extrn lee_2: near
extrn lee_4: near
extrn print_1: near
extrn print_2: near
extrn print_4: near
extrn salto: near
extrn show: near
extrn lee_dec: near
extrn print_dec: near
extrn print_neg: near
.stack

.data
dato1 db 5 dup(?)
dato2 db 5 dup(?)
ans db 5 dup(?) 

.code

main:

	mov ax,@data
	mov ds,ax
	
	
	mov bx, offset dato1
	mov cx,5
	
l1:
	call lee_2
	mov  [ bx  ] , al
	inc bx
	loop l1
	call salto
	
	mov bx, offset dato2 
	mov cx,5
	
l2:
	call lee_2
	mov  [ bx  ] , al
	inc bx
	loop l2
	call salto
	
	
	;hasta este punto ya hemos leido los dos numeros de 10 digitos
	

	mov cx,04	
	mov bx , offset [ dato1 + 4] 
	clc ; con esto limpiamos el carrie
	;call salto
pr:	
	mov al ,  [ bx  ] 
	adc al ,  [ bx + 5 ]
	daa
	push ax
	dec bx
	loop pr

	mov al ,  [ bx  ] 
	adc al ,  [ bx + 5 ]
	daa
	jnc cc 
	call carrie
	cc:
	push ax
	
	
	
	
	
	mov cx,05
	
pp:
	pop dx
	call print_2
	loop pp
	call salto
	
	.exit 0


end