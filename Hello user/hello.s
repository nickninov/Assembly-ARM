@ Ask the user for their first
@ and last name and greet them

.include "length.s"

.data
    .balign 4
        return:     .word   0
    format:         .asciz  "%s"
    msg1:           .asciz  "Enter first name: "
    msg2:           .asciz  "Enter last name: "
    greet:          .asciz  "Hello %s %s!\n"
    fstName:        .fill   11, 1, 0        @ Allocate 11 bytes for first name
    lstName:        .fill   11, 1, 0        @ Allocate 11 bytes for last name
    temp:           .fill   11, 1, 0        @ Temporary store the user input

.text
.global main
main:
    LDR R10, =return        @ Load R10 with address of return
    STR LR, [R10]           @ Store current LR value in return

    @ Display message
    LDR R0, =msg1           
    BL printf               @ Call C function

@ Ask user for first name
input1: 
    LDR R0, =format         
    LDR R1, =temp
    BL scanf                @ Call C function

    length temp fstName 11  @ Cast macro for first name

@ Display message
input2:
    LDR R0, =msg2           
    BL printf               @ Call C function

    @ Ask user for last name
    LDR R0, =format         
    LDR R1, =temp
    BL scanf                @ Call C function

    length temp lstName 11  @ Cast macro for last name

end:
    @ Display message
    LDR R0, =greet
    LDR R1, =fstName
    LDR R2, =lstName
    BL printf

    @ Exit program
    LDR LR, [R10]           @ Load return value in R10
    BX LR                   @ Exit main function in C

@ C programming functions
.global printf              @ Display message on terminal screen
.global scanf               @ Read user input