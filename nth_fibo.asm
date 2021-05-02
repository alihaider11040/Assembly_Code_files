[org 0x0100]
jmp start

fibo_Number:
		push ax
		push cx
		add cx, dx
		pop dx
		mov bx, cx
		pop ax
		dec ax
		cmp ax, 0
			jnz fibo_Number

	ret 2
start:
	mov dx, 0 ;first number
	mov cx, 1 ;2nd number
	
	mov bx, 0 ; for next fibo number
	mov ax, 7 ; nth fibo terms 
	push ax
	call fibo_Number
	mov ax, bx

terminate:

mov ax, 0x4c00
int 21h