; ----------------------------------------------
; ---- EXTRACTOR DE DATOS DE UN ARCHIVO MP3 ----
; ----------------------------------------------
; Obtiene los siguientes datos
;   * Título de la pista
;	* Artista
;	* Título del Álbum
;	* Género
;   * Num. de pista
;   * Año
; 
; ---------------------------------------------
; ----           Elaborado por             ----
; ----     PERALTA ROSALES OSCAR ESAU      ----
; ----        Ing. en Computación          ----
; ---------------------------------------------
;
;
; NOTA: El nombre del archivo mp3 debe estar sin espacios para que pueda ser reconocido no debe superar los 31 caracteres
;       Se debe agregar la extensión ".mp3" al final del nombre
;		El archivo principal "song" Se debe ligar junto con el archivo de funciones "fun"
;

.model small
extrn newLine:near
extrn des1:near
extrn hexToDec:near
.386
.stack
.data
nombre 	db 31 dup(0)
bufer 	db 1 dup('$')
Dkey 	db 4 dup(0) 
Dtmp 	db 255 dup(0)
fid		dw ?
.code

; ------------------- Macros --------------- ;

print macro cadena
local dbcad,dbfin,salta
	pusha	;respalda todo
	push ds	;respalda DS,porque vamos a usar segmento de código
	mov dx,cs	;segmento de código será también de datos
	mov ds,dx
	
	mov dx,offset dbcad ;dirección de cadena(en segmento de código)
	mov ah,09h
	int 21h	;desplegar
	jmp salta ;saltar datos para que no sean ejecutados
dbcad db cadena	;aquí estará la cadena pasada en la sustitución
dbfin db 24h ;fin de cadena
	salta: pop ds ;etiqueta local de salto, recuperar segmento de datos
		   popa	  ;recuperar registros
endm

saveByte macro pos
	push bx
	mov dl,bufer
	mov bx,offset Dkey
	mov Dkey[bx+pos],dl
	pop bx
endm

find_Key macro l1, l2, l3, l4
local et1,et2,et3,et4
	xor ax,ax
	xor cx,cx
	mov bx,offset Dkey
	mov cl,l1
	mov dl,Dkey[bx]
	cmp cl,dl
	jne et1
	add ax,1
   et1:
  	mov cl,l2
    mov dl,Dkey[bx+1]
	cmp cl,dl
	jne et2
	add ax,1
   et2:
   	mov cl,l3
   	mov dl,Dkey[bx+2]
	cmp cl,dl
	jne et3
	add ax,1
   et3:
    mov cl,l4
   	mov dl,Dkey[bx+3]
	cmp cl,dl
	jne et4
	add ax,1
   et4:
endm

;----------------------- Main ------------------------;

main:
	mov ax,@data
	mov ds,ax
	mov es,ax
	
	call getName
	print "Abriendo Archivo... "
	call newLine

	call findTit
	print "Titulo: "
	call printCad

	call findArt
	print "Artista: "
	call printCad

	call findAlb
	print "Album: "
	call printCad

	call findGen
	print "Genero: "
	call printCad

	call findTrack
	print "Num. Pista: "
	call printCad

	call findYear
	print "Year: "
	call printCad
	
	call newLine
	print "Nota: Si el genero es un numero checar su correspondiente en la lista"
	call newLine
	
sale:
	nop
	.exit 0

;---------------------- Funciones --------------------;

; Abre el Archivo
openArch:
	mov al,0
	mov ah,3Dh
	mov dx,offset nombre
	int 21h
	jnc salArch
	print "Error al abrir el Archivo: "
	call ferror
	jmp saleA
   salArch:
   	call newLine
	ret
   saleA:
    .exit 0

; Lee los primeros 4 bytes del archivo y reinicia el buffer Dtmp
reset:
	push cx
	call getByte
	saveByte 0
	call getByte
	saveByte 1
	call getByte
	saveByte 2
	call getByte
	saveByte 3
	pop cx
	call resetCad
	ret

; Encuentra etiqueta de titulo
findTit:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000 ; offset de bytes maximos a leer para encontrar la una etiqueta
   c1:
   	push cx
	call check_tit2
	cmp ax,4
	jne c2
	call getTit
	pop cx
	jmp salRT
   c2:
	call recorre
	call getByte
	cmp ax,1
	jne salRT
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jmp c1
   salRT:
	ret

; Encuentra etiqueta de Artista
findArt:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000
   c1Art:
   	push cx
	call check_TPE
	cmp ax,4
	jne c2Art
	call getTit
	pop cx
	jmp salART
   c2Art:
	call recorre
	call getByte
	cmp ax,0
	je salART
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jne c1Art
   salART:
	ret

; Encuentra etiqueta de Album
findAlb:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000
   c1Alb:
    push cx
	call check_TALB
	cmp ax,4
	jne c2Alb
	call getTit
	pop cx
	jmp salALB
   c2Alb:
	call recorre
	call getByte
	cmp ax,0
	je salALB
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jne c1Alb
   salALB:
	ret

; Encuentra etiqueta de Genero
findGen:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000
   c1Gen:
   	push cx
	call check_TCON
	cmp ax,4
	jne c2Gen
	call getTit
	pop cx
	jmp salGen
   c2Gen:
	call recorre
	call getByte
	cmp ax,0
	je salGen
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jne c1Gen
   salGen:
	ret

; Encuentra etiqueta de Num. de pista
findTrack:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000
   c1TK:
    push cx
	call check_TRCK
	cmp ax,4
	jne c2TK
	call getTit
	pop cx
	jmp salTK
   c2TK:
	call recorre
	call getByte
	cmp ax,0
	je salTK
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jne c1TK
   salTK:
	ret

; Encuentra etiqueta de Año
findYear:
	call openArch
	mov fid,ax
   	call reset
   	mov cx,10000
   c1TY:
   	push cx
	call check_TYER
	cmp ax,4
	jne c2TY
	call getTit
	pop cx
	jmp salTY
   c2TY:
	call recorre
	call getByte
	cmp ax,0
	je salTY
	pop cx
	sub cx,1
	cmp cx,0
	je salTY
	saveByte 3
	jne c1TY
   salTY:
	ret

; Lee un byte en bufer
getByte:
	push bx
	mov bx,fid
	mov ah,3Fh
	mov cx,1
	mov dx,offset bufer
	int 21h
	jnc sigue2
	call ferror
	jmp sale2
  sigue2:
  	pop bx
	ret
  sale2:
    .exit 0

; Imprime un byte leido en bufer
printByte:
	mov dx,ax	;para numero de letras leidas
	cmp dx,1
	jne s1
	push dx
	mov dl,bufer
	mov ah,02h 
	int 21h
	pop dx
   s1:
	ret

; ----- Encuntran una etiqueta en Dkey ----;
check_tit2:
	find_Key 'T' 'I' 'T' '2'
  	ret

check_TPE:
	find_Key 'T' 'P' 'E' '1'
	ret

check_TALB:
	find_Key 'T' 'A' 'L' 'B'
	ret

check_TCON:
	find_Key 'T' 'C' 'O' 'N'
	ret

check_TYER:
	find_Key 'T' 'Y' 'E' 'R'
	ret

check_TRCK:
	find_Key 'T' 'R' 'C' 'K'
	ret

ferror:
	print "Error "
	mov dx,ax
	call hexToDec
	call newLine
	ret

; Recorre los bytes leidos Dkey a la derecha, simulando una ventana
recorre:
	push bx
	mov bx,offset Dkey
	mov dl,Dkey[bx+1]
	mov Dkey[bx],dl
	mov dl,Dkey[bx+2]
	mov Dkey[bx+1],dl
	mov dl,Dkey[bx+3]
	mov Dkey[bx+2],dl
	pop bx
	ret

; Obtiene una cadena despues de encontrar un etiqueta en Dtmp finalizada con 0h
getTit:
	call jmpIni ;comemos 7 bytes y obtenemos tamaño de la cadena
	mov cx,ax ; tamaño de la cadena
	mov bx,offset Dtmp
   ci1:
    push cx
    push bx
    call getByte
    pop bx
    pop cx
    mov dl,bufer
    mov Dtmp[bx],dl
    add bx,1
    sub cx,1
    cmp cx,1
    je sal1
    jmp ci1
   sal1:
	mov Dtmp[bx],0h
	ret

; Imprime Dtmp
printCad:
	push bx
	mov bx,offset Dtmp
   cp:
	mov dl,Dtmp[bx]
	cmp dl,0
	je sal2
	mov ah,02h
	int 21h
	add bx,1
	jmp cp
   sal2:
    call newLine
    pop bx
	ret

; Lee los 7 bytes seguidos de una etiqueta, el byte 4 indica el tamano de la cadena siguiente 
jmpIni:
	call getByte
	call getByte
	call getByte
	call getByte
	xor ax,ax
	mov al,bufer
	push ax
	call getByte
	call getByte
	call getByte
	pop ax
	ret

; Reinicia DTMP con "NULL"
resetCad:
	push bx
	mov bx,offset Dtmp
	mov Dtmp[bx],'N'
	mov Dtmp[bx+1],'U'
	mov Dtmp[bx+2],'L'
	mov Dtmp[bx+3],'L'
	mov Dtmp[bx+4],0h
	pop bx
	ret

;Obtiene el nombre del archivo mp3 a analizar
getName:
	print "Nombre del Archivo: "
	mov bx,offset nombre
	cna:
	mov ah,01h
	int 21h
	cmp al,0Dh
	je salna
	mov nombre[bx],al
	add bx,1
	jmp cna
    salna:
    mov nombre[bx],0h
	ret

end

;-------------- Lista de Generos -------------;
;  0. Blues
;  1. Classic Rock
;  2. Country
;  3. Dance
;  4. Disco
;  5. Funk
;  6. Grunge
;  7. Hip-Hop
;  8. Jazz
;  9. Metal
; 10. New Age
; 11. Oldies
; 12. Other
; 13. Pop
; 14. R&B
; 15. Rap
; 16. Reggae
; 17. Rock
; 18. Techno
; 19. Industrial
; 20. Alternative
; 21. Ska
; 22. Death Metal
; 23. Pranks
; 24. Soundtrack
; 25. Euro-Techno
; 26. Ambient
; 27. Trip-Hop
; 28. Vocal
; 29. Jazz+Funk
; 30. Fusion
; 31. Trance
; 32. Classical
; 33. Instrumental
; 34. Acid
; 35. House
; 36. Game
; 37. Sound Clip
; 38. Gospel
; 39. Noise
; 40. AlternRock
; 41. Bass
; 42. Soul
; 43. Punk
; 44. Space
; 45. Meditative
; 46. Instrumental Pop
; 47. Instrumental Rock
; 48. Ethnic
; 49. Gothic
; 50. Darkwave
; 51. Techno-Industrial
; 52. Electronic
; 53. Pop-Folk
; 54. Eurodance
; 55. Dream
; 56. Southern Rock
; 57. Comedy
; 58. Cult
; 59. Gangsta
; 60. Top 40
; 61. Christian Rap
; 62. Pop/Funk
; 63. Jungle
; 64. Native American
; 65. Cabaret
; 66. New Wave
; 67. Psychadelic
; 68. Rave
; 69. Showtunes
; 70. Trailer
; 71. Lo-Fi
; 72. Tribal
; 73. Acid Punk
; 74. Acid Jazz
; 75. Polka
; 76. Retro
; 77. Musical
; 78. Rock & Roll
; 79. Hard Rock

