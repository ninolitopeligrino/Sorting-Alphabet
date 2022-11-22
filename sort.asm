.model small
.code

org 100h
jmp main

string label byte
max db 20 
actlen db ?
kybd db 21 dup ('$') 

final1 db 21 dup ('$')
final2 db 21 dup ('$')

prompt db 'Enter String: $'

main proc near
    mov ah, 03h
    int 10h
    
    call input
    call a10
    call store1 
    
    mov ah, 02h
    mov bh, 00h
    mov dx, 0100h
    int 10h
    
    call input
    call a10
    call store2
    
    call print
    
    mov ah, 4ch
    int 21h
    
main endp

input proc near
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    mov ah, 0ah
    lea dx, string
    int 21h  
    ret
input endp 

a10 proc near 
     
    mov si, 0
    mov cx, 00h
    mov cl, actlen
    
compare1:
    mov ah, kybd[si]
    mov al, kybd[si+1]
    cmp ah, al
    ja swap 
    
    inc si
    loop compare1  
    jmp print
    
swap:  
    mov kybd[si], al
    mov kybd[si+1], ah
    mov cl, actlen
    mov si, 0
    loop compare1 
    
    ret
    
a10 endp 

store1 proc near
    mov si, 0
    mov cx, 00h
    mov cl, actlen
    
transfer1:
    mov ah, kybd[si]
    mov final1[si], ah
    inc si
    loop transfer1
    
    ret
    
    
store1 endp

store2 proc near
    mov si, 0
    mov cx, 00h
    mov cl, actlen
    
transfer2:
    mov ah, kybd[si]
    mov final2[si], ah
    inc si
    loop transfer2
    
    ret
    
    
store2 endp

print proc near

    mov ah, 02h
    mov bh, 00h
    mov dx, 0200h
    int 10h
    
    mov ah, 09h
    lea dx, final1
    int 21h
    
    mov ah, 02h
    mov bh, 00h
    mov dx, 0300h
    int 10h
    
    mov ah, 09h
    lea dx, final2
    int 21h 
    
    ret
print endp