[org 0x0100]
jmp start
array1: dw 0000h, 0000h, 0000h, 0000h
array2: db 00h, 00h, 00h, 00h
array3: dw 0000h, 0000h, 0000h, 0000h

roll_number: dw 2327h


start:
;first requirement to generate combinations of roll_number i.e 2327

mov bx,roll_number
mov ax ,[bx]           ;setting value of ax

mov bx,array1
mov [bx],ax         ; unrotated value to first index 

rol ax,4                ;3272
add bx,2
mov [bx],ax       ; most significant byte to least sig

rol ax,4  
add bx,2              ; again rotate each nibble to left
mov [bx],ax       ;2723

rol ax,4
add bx,2
mov [bx],ax       ;7232

rol ax,4                ;2327 in ax again and array1 will be set
; all cobinations have been stored in array1 ecah of 16 bit


;generating second requirement that is 8 bit pairs in array2 
mov bx,array2

mov al, byte[roll_number+1]      ; 23 in al
mov [bx],al

mov cl,byte[roll_number]         ;27 in cl
add bx,1
mov [bx],cl

and al ,0xF0            ;making al 20
and cl,0x0f             ;cl is 07

add al,cl
add bx,1               ;pair of 1st and 4th
mov [bx],al

mov al, byte[roll_number+1]      ; 23 in al


mov cl,byte[roll_number]        ;27 in cl  


and al ,0x0f           ;making al 03
and cl,0xf0            ; cl is 20

rol al,4               ;al is 30
rol cl,4               ;cl is 02

add al,cl              ;results 23 i.e second and third pair
add bx,1
mov [bx],al
; 4 8bit pairs stored in array2 
; last requirement to subract and store in array3
;db are 8bit but array 1 are of 16bit so we have to change 8 bit to 16bit

mov bx,array2
mov si,array1
mov di,array3
mov ax,0
mov ax, [bx]        ;match the operand size
sub ax,[si]
mov [di],ax         ;storing at respective index in array3

; adress: 010f FLAGS: CF=0 :ZF=0:SF=0:OF=0

mov ax,0
add bx,1
mov ax, [bx]        ;match the operand size
add si,2
sub ax,[si]
add di,2
mov [di],ax         ;storing at respective index in array3

; adress: 0111 FLAGS: CF=1 :ZF=0:SF=1:OF=0

mov ax,0
add bx,1
mov ax, [bx]        ;match the operand size
add si,2
sub ax,[si]
add di,2
mov [di],ax         ;storing at respective index in array3

;adress: 0113 FLAGS: CF=0 :ZF=0:SF=1:OF=0

mov ax,0
add bx,1
mov ax, [bx]        ;match the operand size
add si,2
sub ax,[si]
add di,2
mov [di],ax         ;storing at respective index in array3

;adress: 0115 FLAGS: CF=0 :ZF=0:SF=1:OF=0

;subtraction results stored
mov ax, 0x4c00
int 0x21