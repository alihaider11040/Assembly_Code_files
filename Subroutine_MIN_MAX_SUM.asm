[org 0x0100]
jmp start
data: dw 2, 4, 6
min: dw 0
max: dw 0
sums dw 0






max_number:
	mov bp,sp; snap of stack
    push ax; saving values on stack
    push bx
    push si


mov bx,[bp+4]; axcessing paramater from stack passed by main
mov cx,[bp+2]

mov ax,[bx]
mov si,[bx+2]
cmp ax,si
jb l4
mov [bp+6],ax
l4:

mov [bp+6],si
mov ax,[bx+4]
cmp ax,si
jb l5
mov [bp+6],ax

l5:

mov [bp+6],si
;retreiving values of allregister used in sub routine
pop si
pop bx
pop ax

ret 4; clearing stack of 32 bits of parameters that are cx and bx


	
sum:
mov bp,sp; taking snap of stack pointer
push ax
push bx
push si
mov ax,0
mov si,0
mov bx,[bp+4]; adress to bp
mov si,[bp+2]; count to si
shl si,1;si into 2
sub si,2

l1:
add ax,[bx+si];calculating sum
sub si,2
cmp si,-2
jne l1

mov [bp+6],ax; at end of stack sum has been placed

pop si
pop bx
pop ax

ret 4

min_number:
	mov bp,sp; snap of stack
push ax
push bx
push si


mov bx,[bp+4]
mov cx,[bp+2]

mov ax,[bx]
mov si,[bx+2]
cmp ax,si
jb l2
mov [bp+6],si
l2:
mov [bp+6],ax

mov ax,[bx+4]
cmp ax,si
jb l3

mov [bp+6],si
l3:
mov [bp+6],ax

pop si
pop bx
pop ax

ret 4

start:
	mov bx, data
	mov cx, 3
	mov ax, 0
   
   sub sp,2 ; making place on stack for return of sum
	push bx 
	push cx
	call sum
	
	pop ax
	mov [sums], ax;
	
	sub sp,2; making place on stack for return of min_number 
	push bx 
	push cx
	call min_number
	
	

pop ax
mov [min],ax

    sub sp,2; making place on stack for return of max_number 
	push bx 
	push cx
	call max_number
pop ax
mov [max],ax;
mov ax, 0x4c00
int 21h