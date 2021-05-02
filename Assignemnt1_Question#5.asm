
[org 0x0100]
jmp start

key :       dd 23cde689h      
plain_text: dd 15d3c257h

from_1st_bit_in: dd 0xAAAAAAAA ;every 2nd bit is 1 starting from 1st_bit
from_2nd_bir_in: dd 0x55555555 ;every 2nd bit is 1 starting from 2nd_bit

Encrpted: dd 0

start:

mov bx,word[key]    ;lower 16 bits of key in bx
mov ax,word[key+2]  ;upper 16 bits of key in ax

xor bx,word[from_1st_bit_in]   ;lower 2byte complement
xor ax, word[from_1st_bit_in+2];upper 2 bytes complement

shl bx,1           ;rotating 32 bit number
rcl ax,1
jnc l1
add bx,1
l1:
clc
mov cx,word[plain_text+2]; add the given plain_text
mov dx,word[plain_text]
add dx,bx                ;Encrpted the plain_text for round 1
adc cx,ax

;round 1 completed
;saving value
mov word[Encrpted],dx
mov word[Encrpted+2],cx;
;round 2 begins




xor bx,word[from_2nd_bir_in]   ;complement of seleted bits
xor ax ,word[from_2nd_bir_in+2];
;rotating the 32 bits to right
shr ax,1;
rcr bx,1;
jnc l2
add ax ,8000h
l2:
clc
add word[Encrpted],bx          ;Adding encryption for the round_2
adc word[Encrpted+2],ax

;round 2 compplete and saving values

;round 3

xor bx,word[from_1st_bit_in]   ;lower 2byte complement
xor ax, word[from_1st_bit_in+2];upper 2 bytes complement

shl bx,1           ;rotating 32 bit number
rcl ax,1
jnc l3
add bx,1
l3:
clc
add  word [Encrpted],bx
adc word[Encrpted+2],ax;


;end of round 3 and updated value of Encrpted
;round 4


xor bx,word[from_2nd_bir_in]   ;Complementing selective bits
xor ax ,word[from_2nd_bir_in+2];
;rotation of 32 bits to right
shr ax,1;
rcr bx,1;
jnc l4
add ax,8000h
l4:
clc
add word[Encrpted],bx          ;encryption of round_4
adc word[Encrpted+2],ax

mov ax, 0x4c00 ; terminate program
int 21h