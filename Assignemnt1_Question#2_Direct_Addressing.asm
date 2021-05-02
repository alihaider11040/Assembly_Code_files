[org 0x0100]
jmp start
array1: dw 0000h, 0000h, 0000h, 0000h
array2: db 00h, 00h, 00h, 00h
array3: dw 0000h, 0000h, 0000h, 0000h

roll_number: dw 2327h


start:
;first requirement to generate combinations of roll_number i.e 2327

mov ax ,[roll_number]           ;setting value of ax
mov [array1],ax         ; unrotated value to first index 

rol ax,4                ;3272
mov [array1+2],ax       ; most significant byte to least sig

rol ax,4                ; again rotate each nibble to left
mov [array1+4],ax       ;2723

rol ax,4
mov [array1+6],ax       ;7232

rol ax,4                ;2327 in ax again and array1 will be set
; all cobinations have been stored in array1 ecah of 16 bit


;generating second requirement that is 8 bit pairs in array2 
mov bl, byte[roll_number+1]      ; 23 in bl
mov [array2],bl

mov cl,byte[roll_number]         ;27 in cl
mov [array2+1],cl

and bl ,0xF0            ;making bl 20
and cl,0x0f             ;cl is 07

add bl,cl               ;pair of 1st and 4th
mov [array2+2],bl

mov bl, byte[roll_number+1]      ; 23 in bl


mov cl,byte[roll_number]        ;27 in cl  


and bl ,0x0f           ;making bl 03
and cl,0xf0            ; cl is 20

rol bl,4               ;bl is 30
rol cl,4               ;cl is 02

add bl,cl              ;results 23 i.e second and third pair
mov [array2+3],bl
; 4 8bit pairs stored in array2 
; last requirement to subract and store in array3
;db are 8bit but array 1 are of 16bit so we have to change 8 bit to 16bit

mov ax,0
mov ax, [array2]        ;match the operand size
sub ax,[array1]
mov [array3],ax         ;storing at respective index in array3

; adress: 010f FLAGS: CF=0 :ZF=0:SF=0:OF=0

mov ax,0
mov ax, [array2+1]        ;match the operand size
sub ax,[array1+2]
mov [array3+2],ax         ;storing at respective index in array3

; adress: 0111 FLAGS: CF=1 :ZF=0:SF=1:OF=0

mov ax,0
mov ax, [array2+2]        ;match the operand size
sub ax,[array1+4]
mov [array3+4],ax         ;storing at respective index in array3

;adress: 0113 FLAGS: CF=0 :ZF=0:SF=1:OF=0

mov ax,0
mov ax, [array2+3]        ;match the operand size
sub ax,[array1+6]
mov [array3+6],ax         ;storing at respective index in array3

;adress: 0115 FLAGS: CF=0 :ZF=0:SF=1:OF=0

;subtraction results stored
mov ax, 0x4c00
int 0x21