.model small

.data
    cadena db 5,0,0,0,0,0,0
    peso db 8, 4, 2, 1
 
.code
    mov ax, seg cadena ;inicializa el valor del segmento de datos
    mov ds, ax ; segmentacion
   
    mov dx, offset cadena ;captura de cadena de caracteres en variable cadena
    mov ah, 0ah
    int 21h
    
    sub cadena [2],48  
    sub cadena [3],48
    sub cadena [4],48
    sub cadena [5],48    
    
     
    
    ;empezamos las formulas por la parte del sumatorio (comun para los dos)
    mov al, cadena[5]
    mul peso[3] 
    mov bl,al 
    mov al, cadena[4]                
    mul peso[2]  
    add bl,al
    mov al, cadena[3]
    mul peso[1]
    add bl,al    
   
    ;vemos si el numero es positivo o negativo
    cmp cadena[2],0                   
    je pos
    jne nega 
   
pos:    
    ;al ser positivos el primer bit va a ser 0 por lo que el resultado con la formula
    ;completa va a ser el mismo que el que tenemos ya, asi que no hace falta que terminemos
    ;la formula
    
    ;COMPLEMENTO A 1
    
    mov cl, bl ; en cl guardamos el numero
	add cl, 48 ; lo ponemos en codigo ascii
   	mov ch, 43 ; guardamos en ch el signo +
    

    mov al, 03h;inicializacion segmento extra
    mov ah, 00h
    int 10h
    
    mov ax, 0B800h
    mov es,ax
    mov dl, 0 ; inicializacion registro indexacion
    mov ah, 00001111b ;formato del caracter
    mov al, ch
    mov es: [DI],ax ;escritura del +
    mov al, cl
    mov es: [DI+2], ax; escritura del numero 
    
    mov ah, 00h    ;mantenemos la pantalla
    int 16h
           
           
    ; COMPLEMENTO A 2
    
    mov cl, bl ; en cl guardamos el numero
	add cl, 48 ; lo ponemos en codigo ascii
   	mov ch, 43 ; guardamos en ch el signo +
    

    mov al, 03h;inicializacion segmento extra
    mov ah, 00h
    int 10h
    
    mov ax, 0B800h
    mov es,ax
    mov dl, 0 ; inicializacion registro indexacion
    mov ah, 00001111b ;formato del caracter
    mov al, ch
    mov es: [DI],ax ;escritura del +
    mov al, cl
    mov es: [DI+2], ax; escritura del numero


    mov ah, 00h    ;mantenemos la pantalla
    int 16h
    
    JMP FIN   ;saltamos al final porque ya hemos terminado
   



nega:  
      
    ;COMPLEMENTO A 1 
    mov al, peso[0] ;completamos la formula con el bit de signo
    dec al
    mul cadena[2]  
    sub al,bl  
    
    
    mov cl, al ; en cl guardamos numero
    add cl, 48 ;lo ponemos en codigo ascii
   

    mov al, 03h;inicializacion segmento extra
    mov ah, 00h
    int 10h
    
    mov ax, 0B800h
    mov es,ax
    mov dl, 0 ; inicializacion registro indexacion
    mov ah, 00001111b ;formato del carácter
    mov al, 45  ; signo menos en ascii
    mov es:[DI],AX ;escribimos -
    mov al, cl
    mov es: [DI+2],ax ;escritura del numero
 

    mov ah, 00h  ;mantenemos la pantalla
    int 16h


    
   ;COMPLEMENTO A 2
	mov al, peso[0]
	mul cadena[2]
	sub al,bl
	
	
    mov cl, al ; en cl guardamos el numero
    add cl, 48 ;lo ponemos en codigo ascii
  

    mov al, 03h;inicializacion segmento extra
    mov ah, 00h
    int 10h
    
    mov ax, 0B800h
    mov es,ax
    mov dl, 0 ; inicializacion registro indexacion
    mov ah, 00001111b ;formato del caracter
    mov al,45
    mov es: [DI],ax ;escribimos el signo -
    mov al, cl
    mov es: [DI+2],ax ;escritura del numero
    	


    mov ah, 00h  ;mantenemos pantalla
    int 16h
   
fin:
    mov ah, 4ch
    int 21h
end