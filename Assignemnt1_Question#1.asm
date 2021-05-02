[org 0x0100]

mov ax,[data]   ; type 1 direct addressing mode i.e moving data to ax

mov ax,[data2+2]; second element of data2 using direct addressing and numbers


mov ax,data     ;indirect addressing using register
mov bx,0
add ax,bx;


mov cx ,3
mov bx,0
mov si,0

l1:

add bx,[data2+si];register indirect addressing with displacement
add si,1
cmp si,3
jne l1



mov bx,data2
mov si,0
add ax,[bx +si] ;bASE and index addressing

add ax,[bx+si+2]; base +index+ constant adrssing to axcess 2D array

add ax,[ds:bx+si]; segment offset pair and index


mov ax,0x4c00
int 0x21h
data dw 1
data2 dw 1,2,3