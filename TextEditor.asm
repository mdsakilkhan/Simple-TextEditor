model small
.stack 100h
.data
char	db 0
lineset dw 0
pos		dw 0
pos_x	db 0
pos_y	db 0
var_llc db 0
txtpos  dw 0
strt1	dw 0
file	db 20 dup(0)
prompt1	db " Enter File Name: 0"
prompt2	db "                         .txt0"
prompt3	db "* File Saved *0"
prompt4	db "* File Does Not Exist * Try Again *0"
prompt5	db " Text Editor                                     Press (Enter) for Reading Mode0"
line1 	db 80 dup(0)
line2 	db 80 dup(0)
line3 	db 80 dup(0)
line4 	db 80 dup(0)
line5 	db 80 dup(0)
line6 	db 80 dup(0)
line7 	db 80 dup(0)
line8 	db 80 dup(0)
line9	db 80 dup(0)
line10 	db 80 dup(0)
line11 	db 80 dup(0)
line12 	db 80 dup(0)
line13 	db 80 dup(0)
line14 	db 80 dup(0)
line15 	db 80 dup(0)
line16 	db 80 dup(0)
line17 	db 80 dup(0)
line18 	db 80 dup(0)
line19 	db 80 dup(0)
line20 	db 80 dup(0)
menu	db 10, 10
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "              ___________  ________  _______  ______________  ___               "
		db "             /_  __/ __/ |/_/_  __/ / __/ _ \/  _/_  __/ __ \/ _ \              "
		db "              / / / _/_>  <  / /   / _// // // /  / / / /_/ / , _/              "
		db "             /_/ /___/_/|_| /_/   /___/____/___/ /_/  \____/_/|_|               "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                BY: Md Sakil Khan                               "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                  Create New Text (1)     (2) Open Existing Text                "
		db "                                                                                "
		db "                                                                                "
		db "                            Guide (3)     (4) Quit                              "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                                                               "
message	db 10, 10
		db "                                                                                "
		db "                                                                                "
		db "    ____ ____ ____ ____ ____ _________                                          "
		db "   ||G |||u |||i |||d |||e |||       ||                                         "
		db "   ||__|||__|||__|||__|||__|||_______||                                         "
		db "   |/__\|/__\|/__\|/__\|/__\|/_______\|                                         "
		db "                                                                                "
		db "                                                                                "
		db "    - Press (tab) to save                                                       "
		db "                                                                                "
		db "    - Go to top or bottom of the page to scroll up or down                      "
		db "                                                                                "
		db "    - Press (backspace) to delete left character                                "
		db "                                                                                "
		db "    - Press (delete) to delete right character                                  "
		db "                                                                                "
		db "    - Press (esc) to go back from anywhere in the code                          "
		db "                                                                                "
		db "    - Use arrow keys to move cursor                                             "
		db "                                                                                "
		db "    - Press (enter) to view wrap text mode                                      "
		db "                                                                                "
		db "                                                                                "
		db "                                                                                "
		db "                                                                               "
text	db 10000 dup(0)
.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov si, offset menu
	mov cx, 1999
l_menu:
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_menu
	
	mov bx, 0
	mov cx, 10000
l_clear:
	mov al, 32
	mov text[bx], al
	inc bx
	loop l_clear

	mov lineset, 0

start:	
	mov dl, 39
	mov dh, 17
    mov ah, 02h
	mov bh, 00
	int 10h
	
	mov ah, 1
	int 21h
	
	cmp al, 49
	je open_new1
	cmp al, 50
	je open_exist1
	cmp al, 51
	je message1
	cmp al, 52
	je quit1
	cmp al, 27
	je quit1
	jmp start

open_new1: jmp open_new
open_exist1: jmp open_exist
quit1: jmp quit

;------------------------------------------------------------------------------------------------
message1:
	mov si, offset message
	mov cx, 2001
l_message:
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_message	
	
	mov ah, 1
	int 21h
	jmp main

;------------------------------------------------------------------------------------------------
open_new:
	mov ah, 2
	mov dx, 10
	int 21h
	int 21h
	
	mov dx, 205
	mov cx, 80
bn1: int 21h
	loop bn1

	mov dx, 10
	mov cx, 20
bn2: int 21h
	loop bn2

	mov dx, 205
	mov cx, 80
bn3: int 21h
	loop bn3
	
	mov dx, 10
	int 21h
	int 21h

	mov pos, 0
	jmp setcursor

;------------------------------------------------------------------------------------------------
notexist:
	mov dl, 32
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h	
	mov si, offset prompt4
	mov cx, 35
l_prompt4:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_prompt4
	jmp print_notexist

open_exist:
	mov ah, 2
	mov dx, 10
	int 21h
	int 21h
	
	mov dx, 205
	mov cx, 80
be1: int 21h
	loop be1

	mov dx, 10
	mov cx, 20
be2: int 21h
	loop be2

	mov dx, 205
	mov cx, 80
be3: int 21h
	loop be3

	mov dx, 10
	int 21h
	int 21h

print_notexist:	
	mov dl, 0
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h
	mov si, offset prompt2
	mov cx, 29
lx_prompt2:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop lx_prompt2

	mov dl, 0
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h	
	mov si, offset prompt1
	mov cx, 18
lx_prompt1:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop lx_prompt1

	mov bx, 0
	mov cx, 7
lx_file1:
	mov ah, 1
	int 21h
	cmp al, 13
	je breakx_file1
	cmp al, 32
	jl main2
	cmp al, 126
	jg main2
	mov file[bx], al
	inc bx
	loop lx_file1
breakx_file1:
	mov al, '.'
	mov file[bx], al
	inc bx
	mov al, 't'
	mov file[bx], al
	inc bx
	mov al, 'x'
	mov file[bx], al
	inc bx
	mov al, 't'
	mov file[bx], al
	inc bx
	mov al, 00
	mov file[bx], al
	
	mov ah, 3dh
	mov al, 0
	mov dx, offset file
	int 21h
	
	cmp ax, 2
	je notexist1

	mov si, ax
	mov ah, 3fh
	mov bx, si
	mov cx, 9999
	mov dx, offset text
	int 21h
	mov ah, 3eh
	int 21h
	
	mov bx, 0
l_replace:
	cmp text[bx], 13
	je replace	
	cmp text[bx], 10
	je replace
	cmp bx, 9999
	je done
	inc bx
	jmp l_replace
replace:
	mov text[bx], 32
	inc bx
	jmp l_replace
done:
	
	mov pos, 0
	jmp print

main2: jmp main
notexist1: jmp notexist

;------------------------------------------------------------------------------------------------
save:
	mov dl, 0
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h
	mov si, offset prompt2
	mov cx, 29
l_prompt2:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_prompt2

	mov dl, 0
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h	
	mov si, offset prompt1
	mov cx, 18
l_prompt1:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_prompt1

	mov bx, 0
	mov cx, 7
l_file1:
	mov ah, 1
	int 21h
	cmp al, 13
	je break_file1
	cmp al, 32
	jl setcursor2
	cmp al, 126
	jg setcursor2
	mov file[bx], al
	inc bx
	loop l_file1
break_file1:
	
	mov dl, 32
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h	
	mov si, offset prompt3
	mov cx, 14
l_prompt3:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop l_prompt3

	mov al, '.'
	mov file[bx], al
	inc bx
	mov al, 't'
	mov file[bx], al
	inc bx
	mov al, 'x'
	mov file[bx], al
	inc bx
	mov al, 't'
	mov file[bx], al
	inc bx
	mov al, 00
	mov file[bx], al
	
	mov ah, 3ch
	mov cx, 0
	mov dx, offset file
	int 21h
	
	mov ah, 3dh
	mov al, 1
	mov dx, offset file
	int 21h
	
	mov si, ax
	mov ah, 40h
	mov bx, si
	mov cx, 9999
	mov dx, offset text
	int 21h
	mov ah, 3eh
	int 21h

setcursor2:	
	jmp setcursor
	
;------------------------------------------------------------------------------------------------
insert:
	mov bx, 9998;-2
	mov cx, 9999;-1
	sub cx, pos
l_insert:	
	mov al, text[bx]
	inc bx
	mov text[bx], al
	sub bx, 2
	loop l_insert
	
	mov bx, pos
	mov al, char
	mov text[bx], al
	add pos, 1
	inc dl
	cmp dl, 80
	je check_insert
	jmp print
check_insert:
	cmp dh, 20
	je check_insert1
	jmp print
check_insert1:
	add lineset, 80
	jmp print
	
;------------------------------------------------------------------------------------------------
backspace:
	cmp pos, 0
	je cursor1
	cmp dl, 0
	mov cx, 10000
	sub cx, pos
	mov bx, pos
	sub bx, 1
l_backspace: 
	inc bx
	mov al, text[bx]
	dec bx
	mov text[bx], al
	inc bx
	loop l_backspace
	sub pos, 1

    dec dl
	cmp dl, 0
	jl check_backspace
	jmp print
check_backspace:
	cmp dh, 1
	je check_backspace1
	jmp print
check_backspace1:
	sub lineset, 80
	jmp print

cursor1:	
	jmp setcursor

;------------------------------------------------------------------------------------------------
delete:
	mov cx, 10000
	sub cx, pos
	mov bx, pos
l_delete: 
	inc bx
	mov al, text[bx]
	dec bx
	mov text[bx], al
	inc bx
	loop l_delete

	jmp print

;------------------------------------------------------------------------------------------------
cursor:
	mov ah, 00h
	int 16h
	
	cmp ah, 80
    je down
	cmp ah, 72
    je Up    
	cmp ah, 75
    je Left
	cmp ah, 77
    je Right
	
	cmp al, 27
	je main1
	cmp al, 8
	je backspace1
	cmp ah, 83
	je delete1
	cmp al, 9
	je save1
	cmp al, 13
	je newline1
	mov char, al
	jmp insert

delete1: jmp delete
backspace1: jmp backspace
main1: jmp main
save1: jmp Save
newline1: jmp printwrap
	
Down:
	inc dh
	add pos, 80
	jmp checkcursor
Up: 
	cmp pos, 80
	jl checkcursor1
	sub pos, 80
	dec dh
checkcursor1:
	jmp checkcursor

Left:
	cmp pos, 0
	jg leftck
	jmp setcursor
leftck: 
	sub pos, 1
    dec dl
	cmp dl, 0
	jl check_left
	jmp setcursor
check_left:
	cmp dh, 1
	je check_left1
	jmp setcursor
check_left1:
	sub lineset, 80
	jmp print

Right:
    add pos, 1
	inc dl
	cmp dl, 80
	je check_right
	jmp setcursor
check_right:
	cmp dh, 20
	je check_right1
	jmp setcursor
check_right1:
	add lineset, 80
	jmp print

SetCursor:
	mov pos_x, 0
	mov pos_y, 1
	mov bx, pos
	sub bx, lineset
	mov cx, 0
l_set: 
	cmp bx, 80
	jl break_set
	sub bx, 80
	inc cx
	jmp l_set
break_set:
la:	add pos_y, 1
	loop la
	mov cx, bx
lb: add pos_x, 1
	loop lb
	mov dl, pos_x
	mov dh, pos_y

	mov ah, 02h
    mov bh, 00
    int 10h
	
	jmp cursor

;------------------------------------------------------------------------------------------------
checkcursor:
	cmp dh, 0
	je scrollup
	cmp dh, 21
	je scrolldown
	jmp setcursor

scrollup:
	cmp lineset, 0
	je setcursor1
	sub lineset, 80
	jmp print	
scrolldown:
	add lineset, 80
	jmp print

setcursor1:
	jmp setcursor
	
;------------------------------------------------------------------------------------------------
print:	
	mov dl, 0
	mov dh, 0
	mov ah, 2h
    mov bh, 00
    int 10h	
	
	mov si, offset text
	mov cx, lineset
lla: inc si
	loop lla
	mov var_llc, 0

llc: inc dh
	mov dl, 0
	mov ah, 2h
    mov bh, 00
    int 10h	
	mov cx, 80
	push dx

llb: 
	mov dx, [si]
	cmp dx, 13
	je break_llb
	mov ah, 2
	int 21h
	inc si	
	loop llb
	pop dx
	cmp var_llc, 19
	je break_llc
	add var_llc, 1
	jmp llc
break_llb:
	
	mov ah, 4Ch
	int 21h
	
	inc si
	inc dh
	mov dl, 0
	mov ah, 2h
    mov bh, 00
    int 10h	
	push dx
break_llc:

	push dx
	mov dl, 0
	mov dh, 23
	mov ah, 02h
    mov bh, 00
    int 10h	
	mov si, offset prompt5
	mov cx, 79
lx_prompt5:	
	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop lx_prompt5
	pop dx
	
	jmp setcursor
	
;------------------------------------------------------------------------------------------------
printwrap:
	push dx
	mov ax, lineset
	mov txtpos, ax
	
	mov strt1, 0
	mov cx, 80
la1: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line1[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la1
	sub txtpos, 1
	mov strt1, 79
lb1: mov bx, strt1
	cmp line1[bx], 32
	je break1
	mov line1[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb1
break1:	
	add txtpos, 1

	mov strt1, 0
	mov cx, 80
la2: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line2[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la2
	sub txtpos, 1
	mov strt1, 79
lb2: mov bx, strt1
	cmp line2[bx], 32
	je break2
	mov line2[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb2
break2:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la3: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line3[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la3
	sub txtpos, 1	
	mov strt1, 79
lb3: mov bx, strt1
	cmp line3[bx], 32
	je break3
	mov line3[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb3
break3:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la4: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line4[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la4
	sub txtpos, 1	
	mov strt1, 79
lb4: mov bx, strt1
	cmp line4[bx], 32
	je break4
	mov line4[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb4
break4:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la5: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line5[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la5
	sub txtpos, 1	
	mov strt1, 79
lb5: mov bx, strt1
	cmp line5[bx], 32
	je break5
	mov line5[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb5
break5:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la6: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line6[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la6
	sub txtpos, 1	
	mov strt1, 79
lb6: mov bx, strt1
	cmp line6[bx], 32
	je break6
	mov line6[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb6
break6:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la7: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line7[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la7
	sub txtpos, 1	
	mov strt1, 79
lb7: mov bx, strt1
	cmp line7[bx], 32
	je break7
	mov line7[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb7
break7:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la8: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line8[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la8
	sub txtpos, 1	
	mov strt1, 79
lb8: mov bx, strt1
	cmp line8[bx], 32
	je break8
	mov line8[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb8
break8:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la9: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line9[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la9
	sub txtpos, 1	
	mov strt1, 79
lb9: mov bx, strt1
	cmp line9[bx], 32
	je break9
	mov line9[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb9
break9:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la10: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line10[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la10
	sub txtpos, 1	
	mov strt1, 79
lb10: mov bx, strt1
	cmp line10[bx], 32
	je break10
	mov line10[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb10
break10:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la11: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line11[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la11
	sub txtpos, 1	
	mov strt1, 79
lb11: mov bx, strt1
	cmp line11[bx], 32
	je break11
	mov line11[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb11
break11:	
	add txtpos, 1

	mov strt1, 0
	mov cx, 80
la12: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line12[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la12
	sub txtpos, 1
	mov strt1, 79
lb12: mov bx, strt1
	cmp line12[bx], 32
	je break12
	mov line12[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb12
break12:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la13: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line13[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la13
	sub txtpos, 1	
	mov strt1, 79
lb13: mov bx, strt1
	cmp line13[bx], 32
	je break13
	mov line13[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb13
break13:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la14: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line14[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la14
	sub txtpos, 1	
	mov strt1, 79
lb14: mov bx, strt1
	cmp line14[bx], 32
	je break14
	mov line14[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb14
break14:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la15: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line15[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la15
	sub txtpos, 1	
	mov strt1, 79
lb15: mov bx, strt1
	cmp line15[bx], 32
	je break15
	mov line15[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb15
break15:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la16: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line16[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la16
	sub txtpos, 1	
	mov strt1, 79
lb16: mov bx, strt1
	cmp line16[bx], 32
	je break16
	mov line16[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb16
break16:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la17: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line17[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la17
	sub txtpos, 1	
	mov strt1, 79
lb17: mov bx, strt1
	cmp line17[bx], 32
	je break17
	mov line17[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb17
break17:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la18: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line18[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la18
	sub txtpos, 1	
	mov strt1, 79
lb18: mov bx, strt1
	cmp line18[bx], 32
	je break18
	mov line18[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb18
break18:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la19: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line19[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la19
	sub txtpos, 1	
	mov strt1, 79
lb19: mov bx, strt1
	cmp line19[bx], 32
	je break19
	mov line19[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb19
break19:	
	add txtpos, 1
	
	mov strt1, 0
	mov cx, 80
la20: mov bx, txtpos
	mov al, text[bx]
	mov bx, strt1
	mov line20[bx], al 
	add txtpos, 1
	add strt1, 1
	loop la20
	sub txtpos, 1	
	mov strt1, 79
lb20: mov bx, strt1
	cmp line20[bx], 32
	je break20
	mov line20[bx], 00
	sub txtpos, 1
	sub strt1, 1
	loop lb20
break20:	
	add txtpos, 1

	mov dl, 0
	mov dh, 1
	mov ah, 2h
    mov bh, 00
    int 10h	
	mov si, offset line1
	mov cx, 1600
lc1:	mov dx, [si]
	mov ah, 2
	int 21h
	inc si
	loop lc1
	
	mov dl, 0
	mov dh, 30
	mov ah, 2h
    mov bh, 00
    int 10h	
	
	pop dx
	
	mov ah, 1
	int 21h
	jmp print

;------------------------------------------------------------------------------------------------
quit:
	mov ah, 4Ch
	int 21h
	
main endp
end main