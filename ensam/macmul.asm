.model 	small
extrn 	lee2:near
extrn	des4:near
extrn 	newLine:near
extrn 	hexToDec:near
extrn 	show:near
extrn 	spc:near
.stack
.data
.code
mult 	macro 	p1,p2

		mov 	al,p1
		mov 	cl,p2
		mul 	cl
		
endm

main:

		call 	lee2
        mov 	cl,al
        call 	newLine
        
        call 	lee2
        mult 	al cl
        call 	newLine
        
        mov 	dx,ax
        call 	hexToDec
        call 	spc
        call 	des4
        
        .exit 0
end
