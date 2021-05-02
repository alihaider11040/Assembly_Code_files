[org 0x0100]
jmp start
num1: dd 101245 ; parameter to the sub-routine
num2: dd 0

sparse_number:

push bp           ; saving value of bp;
mov bp,sp         ;saving snap of stack pointer

push ax
push bx           ;stack pushing values
push cx
push dx


mov bx,[bp+6]     ;lower 2byte of parameter in bx
mov ax,[bp+4]     ;upper 2 byte of parameter in ax 


Repeat_bitwise_check:

mov dx,0           ;used as 1 counter
mov cx,32
mov word[num2],1

test_bit:
cmp cx,16                         ;either to check lower or upper bit
jl set_value_bx_for_upper_bytes   ;upper or lower 2 byte

value_setted:
test [num2],bx     ; checking each bit either its 1 or 0 result will be 0 if bit is 0
jz testedbit_zero  ;if the tested bit is 0 we will check next bit

add dx,1           ;condition will reaveals that either its the 1st 1 or second 1
cmp dx,1
je first_one_found

jmp check_next_number; condition that current number is not sparse i.e second consective 1

testedbit_zero:

mov dx,0             ;make sure that we take jump to check_next_number when there are consective 1's
first_one_found:
rol word[num2],1         ;rotating 1 time to left to check next bit
dec cx
cmp cx,0
jne test_bit


mov [bp+8],ax        ; storing upper 2 bytes








pop dx               ;restoring values of register
pop cx
pop bx
pop ax
pop bp

ret 4

check_next_number:

mov bx,[bp+6]     ;lower 2byte of parameter in bx
mov ax,[bp+4]     ;upper 2 byte of parameter in ax 
clc
add bx,1            ;adding 1 to check either next number is sparse_number or not
adc ax,bx           ;exteded addition
mov [bp+6],bx       ;updating value on stack
mov [bp+4],ax

jmp Repeat_bitwise_check

set_value_bx_for_upper_bytes:
mov [bp+6],bx      ;storing value of sparse number on stack lower 2byte
mov bx,ax          ;now bx have upper 2 bytes
jmp value_setted   ;to start program execution

start:

sub sp,4
push word[num1]    ;lower 2 bytes of num1
push word[num1+2]  ;upper 2 bytes of num1
call sparse_number

pop word[num2]  ;
pop word[num2+2];

mov ax, 0x4c00
int 0x21