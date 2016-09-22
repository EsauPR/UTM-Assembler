Proceso sin_titulo
	definir cal1,cal2,cal3,exaF,trabF Como Real
	definir pExa,pExaF,pTF,Cal_final como real
	pExa<-0.55
	pExaF<-0.30
	pTF<-0.13
	escribir "dame la calificacion del examen 1"
	leer cal1
	escribir "dame la calificacion del examen 2"
	leer cal2
	escribir "dame la calificacion del examen 3"
	leer cal3
	escribir "dame la calificacion del examen final"
	leer exaF
	escribir "dame la calificacion del Trabajo final"
	leer trabF
	pPar<- (cal1+cal2+cal3)/3
	cal_final<-pPar*pExa + pExaF*exaF + pTF*trabF;
	escribir "el promedio del alumno es:", cal_final
FinProceso
