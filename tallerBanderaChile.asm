.model small
.386
.stack 64
.data
  msgIndicaciones db "Para que aparezca la bandera presione las flechas:", '$'
  msgFlechaArriba db "Arriba: Franja blanca", '$'
  msgFlechaAbajo db "Abajo: Franja roja", '$'
  msgFlechaIzquierda db "Izquierda: Franja azul", '$'
  msgFlechaDerecha db "Derecha: Estrella", '$'
  msgContinuar db "Presionelas para dibujar o ESC para salir", '$'
  varValidar1 db 0b
  varValidar2 db 0b

.code

inicio proc near
 MOV ax,@DATA
 MOV ds,ax   
 XOR ax,ax

 call INDICACIONES

 SIGUIENTE:
 mov dh,33d
 mov dl,60d
 call UBICAR
 call TECLA

 cmp ah,01h  ; esc
 je FIN
 cmp ah,48H  ; flecha arriba
 je subir 
 cmp ah,50H  ; flecha abajo
 je bajar
 cmp ah,4BH  ; flecha izquierda
 je izqui 
 cmp ah,4DH  ; flecha derecha
 je dere
 
 jmp SIGUIENTE

 subir:
  call PINTARBLANCO
  jmp SIGUIENTE
 
 bajar:
  call PINTARROJO
  jmp SIGUIENTE

 izqui:
  call PINTARAZUL
  jmp SIGUIENTE

 dere:
  call PINTARESTRELLA
  jmp SIGUIENTE

 FIN:
 call LIMPIARBANDERA

 .exit
inicio endp 

INDICACIONES proc near
 call limpiar

 mov dh,03d
 mov dl,08d
 call UBICAR
 mov dx,offset msgIndicaciones
 call MOSTRAR

 mov dh,05d
 mov dl,10d
 call UBICAR
 mov dx,offset msgFlechaArriba
 call MOSTRAR

 mov dh,07d
 mov dl,10d
 call UBICAR
 mov dx,offset msgFlechaAbajo
 call MOSTRAR

 mov dh,09d
 mov dl,10d
 call UBICAR
 mov dx,offset msgFlechaIzquierda
 call MOSTRAR

 mov dh,11d
 mov dl,10d
 call UBICAR 
 mov dx,offset msgFlechaDerecha
 call MOSTRAR

 mov dh,13d
 mov dl,10d
 call UBICAR 
 mov dx,offset msgContinuar
 call MOSTRAR
 ret 
INDICACIONES endp

;****************************************
PINTARBLANCO proc near
  mov ax,0600h
  mov bh,0f0h  ;color
  mov ch,00d      ;inicio de color
  mov cl,00d
  mov dh,12d      ;final de color
  mov dl,80d
	int 10H               	
  ret 
PINTARBLANCO endp

;****************************************
PINTARROJO proc near
  mov ax,0600h
  mov bh,40h  ;color
  mov ch,13d
  mov cl,00d
  mov dh,25d  ;fila      ;final de color
  mov dl,80d  ;columna
	int 10H               	
  ret 
PINTARROJO endp

;****************************************
PINTARAZUL proc near
  mov ax,0600h
  mov bh,10h  ;color
  mov ch,00d      
  mov cl,00d
  mov dh,12d  ;fila      ;final de color
  mov dl,26d  ;columna
	int 10H               	
  ret 
PINTARAZUL endp

;****************************************
PINTARESTRELLA proc near
  mov ax,0600h
  mov bh,0f0h  ;color

  mov ch,02d      
  mov cl,13d
  mov dh,02d
  mov dl,13d 
  int 10H

  mov ch,03d      
  mov cl,12d
  mov dh,04d
  mov dl,14d 
  int 10H

  mov ch,03d      
  mov cl,12d
  mov dh,03d
  mov dl,14d 
  int 10H

  mov ch,05d      
  mov cl,11d
  mov dh,05d
  mov dl,15d 
  int 10H

  mov ch,06d      
  mov cl,05d
  mov dh,06d
  mov dl,21d 
  int 10H

  mov ch,07d      
  mov cl,07d
  mov dh,07d
  mov dl,19d 
  int 10H

  mov ch,08d      
  mov cl,10d
  mov dh,08d
  mov dl,16d 
  int 10H

  mov ch,09d      
  mov cl,09d
  mov dh,09d
  mov dl,12d 
  int 10H

  mov ch,09d      
  mov cl,14d
  mov dh,09d
  mov dl,17d 
  int 10H

  mov ch,10d      
  mov cl,08d
  mov dh,10d
  mov dl,11d 
  int 10H

  mov ch,10d      
  mov cl,15d
  mov dh,10d
  mov dl,18d 
  int 10H

  mov ch,11d      
  mov cl,07d
  mov dh,11d
  mov dl,09d 
  int 10H

  mov ch,11d      
  mov cl,17d
  mov dh,11d
  mov dl,19d 
  int 10H

  ret 
PINTARESTRELLA endp

;****************************************
LIMPIAR proc near         
  mov ax,0600h 
  mov bh,0fh
  mov cx,0000h                   
  mov dx,184FH         	  
  int 10h                  	
  ret                      	
LIMPIAR endp

;****************************************
LIMPIARBANDERA proc near         
  mov ax,0600h 
  mov bh,00h
  mov cx,0000h                   
  mov dx,184FH         	  
  int 10h                  	
  ret                      	
LIMPIARBANDERA endp

;****************************************
UBICAR PROC NEAR
 mov ah,02H
 mov bh,00H
 INT 10H
 RET
UBICAR ENDP

;****************************************
MOSTRAR PROC NEAR
 mov ah,9H
 int 21h
 RET
MOSTRAR ENDP

;****************************************
TECLA proc near  
  mov ah,10H
  int 16h  
  ret
TECLA endp

end inicio