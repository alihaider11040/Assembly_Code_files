[org 0x0100]
mov cx,10
mov ax,0
mov si,0; using as index
mov bp,5333
mov ds,bp
mov di,0002
l1:
mov bx,Array1
add ax,[bx+si]

mov bx,Array2
add ax,[bx+si]

mov bx,Array3
add ax,[bx+si]


mov [di],ax
add si,2
add di,2
sub cx,1
jnz l1

mov ax,0x4c00
int 0x21
Array1: dw 101,200,500,320,550,632,470,747,800,600
Array2: dw 50,99,256,230,550,663,220,55,632,32
Array3: dw 77,23,100,221,560,621,156,254,952,221