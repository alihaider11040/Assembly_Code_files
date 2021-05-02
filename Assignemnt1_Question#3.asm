[org 0x0100]
jmp start

array: dw 10, 13, 96, 16, 18, 51, 88, 45, 2, 4, 3, -1

start:
mov si,0     ;use as counter in array to check either even or odd
mov di,0     ;use as counter to place odd numbers in array

check_again:

mov ax,[array+si]; to check that number is even or odd
shr ax,1
jnc skip

mov ax,[array+si]; changing array
mov [array+di],ax
add di,2


skip:
add si,2
mov ax,[array+si]
cmp ax,-1
jne check_again
;left place will be replaced by -1
place_negative_again:
add di,2
mov ax,-1
mov [array+di],ax
cmp di,si
jne place_negative_again

mov ax, 0x4c00
int 0x21