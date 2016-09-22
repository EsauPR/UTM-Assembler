main:	mov ax,@data
		mov ds,ax
		
		call lee1	;resultado en AL
		mov dl,al
		push dx
		call des1	;entrada en dl
		pop dx
		mov ax,dx
		call des1
		
;lee1	obtine un valor hex
;		resultadoen al
;		altera ah
lee1:	push dx
		push ax

 ll_s1:
		pop ax
		pop dx
		ret
;des1	despliega en ppantall valor hex
;		dato en dl
; 		altera dl
des1:	push ax

		ret
::::::::::::::::::::::::::::::::::::::::::::::::