;Pinte la bandera de Canada
.model small
.386
.stack 64
.data
  msgIndicaciones db "Para que aparezca la bandera presione las flechas:", '$'
  msgFlechaArriba db "Arriba: Franja Roja Derecha", '$'
  msgFlechaAbajo db  "Abajo: Franja Roja Izqquierda", '$'
  msgFlechaIzquierda db "Izquierda: Franja Blanca", '$'
  msgFlechaDerecha db "Derecha: Hoja", '$'
  msgContinuar db "Presionelas para dibujar o ESC para salir", '$'
.code

inicio proc near
 mov ax,@data
 mov ds,ax   

 call INDICACIONES

 SIGUIENTE:
 mov dh,25d
 mov dl,10d
 call UBICAR
 call TECLA

 ;Complete el ascii de tecla correspondiente

 cmp ah,  ; esc
 je Fin
 cmp ah,  ; flecha arriba
 je Arriba 
 cmp ah,  ; flecha abajo
 je Abajo
 cmp ah,  ; flecha izquierda
 je Izqui 
 cmp ah,  ; flecha derecha
 je Dere
 
 jmp SIGUIENTE

 ;Programe cada procedimiento para pintar de forma correcta
  
 Arriba:
  call PINTARROJODERECHO
  jmp SIGUIENTE
 
 Abajo:
  call PINTARROJOIZQUI
  jmp SIGUIENTE

 Izqui:
  call PINTARBLANCO
  jmp SIGUIENTE

 Dere:
  call PINTARHOJA
  jmp SIGUIENTE

 Fin:
 call LIMPIAR

 .exit
inicio endp 

INDICACIONES proc
 call LIMPIAR

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

 mov dh,14d
 mov dl,09d
 call UBICAR 
 mov dx,offset msgContinuar
 call MOSTRAR
 ret 
INDICACIONES endp

;****************************************
;plantilla que se usara para pintar (completar)
PINTARROJODERECHO proc near
  mov ax,0600h
  mov bh,         ;color
  mov ch,         ;inicio de color x
  mov cl,         ;inicio de color y
  mov dh,         ;fin del color x
  mov dl,         ;fin de color y
	int 10H               	
  ret 
PINTARROJODERECHO endp

;****************************************
;franja roja izquierda
PINTARROJOIZQUI proc near               	
  ret 
PINTARROJOIZQUI endp

;****************************************
;franja blanca media
PINTARBLANCO proc near               	
  ret 
PINTARBLANCO endp

;****************************************
;hoja roja
PINTARHOJA proc near
  ret 
PINTARHOJA endp

;****************************************
LIMPIAR proc near         
  mov ax,0600h
  mov bh,0fh      
  mov cx,0000h   
  mov dx,184Fh    
  int 10H        
  ret                      	
LIMPIAR endp

;****************************************
UBICAR proc near
 mov ah,02H       
 mov bh,00H       
 int 10H        
 ret
UBICAR endp

;****************************************
MOSTRAR proc near
 mov ah,9H 
 int 21H         
 ret
MOSTRAR endp

;****************************************
TECLA proc near  
 mov ah,10H      
 int 16H       
 ret
TECLA endp

end inicio