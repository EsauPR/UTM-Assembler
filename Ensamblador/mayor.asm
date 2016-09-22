.model small
extrn lee_2:near
extrn lee_dec:near
extrn print_2:near
extrn salto:near
extrn print_4:near
extrn print_dec:near
extrn show:near
.stack
.data
.code 

mayor macro num1,num2,resu
local salto1,salto2,res
	
	res db 00h
	
	mov al,num1
	mov bl,num2
	
	cmp al,bl
	jge salto1
	
	mov res,bl
	jmp salto2
	
	salto1: mov res,al
	
	salto2: 
	mov resu,res

endm

main: mov ax,@data
	  mov ds,ax
	
	  
	  call lee_dec
	  mov bl,al
	  
	  call salto
	  
	  call lee_dec
	  call salto
	
	  mayor al bl cl
	  
	  mov dh,0h
	  mov dl,cl
	  call print_dec
	  
.exit 0
	
end
