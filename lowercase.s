@ A program that converts uppercase letters to lowercase

.global _start

_start:
    LDR R5, =input          @ Load input register address
    LDR R6, =output         @ Load output register address
    
loop:
    LDRB R0, [R5], #1       @ Load character from input and increment memory
    BL lowercase            @ Call function lowercase

    STRB R0, [R6], #1       @ Store the modified character in output and increment memory
    
    TEQ R0, #0              @ Check if R0 has reached the end of the string
    BNE loop                @ If R0 is not 0 then run loop again

_end:
    MOV R0, #1              @ Write on screen
    MOV R7, #4              @ Send a write request

    LDR R1, =output         @ Load message to register
    SUB R2, R6, R1          @ Get message lengthh

    SVC 0                   @ Do a system call

    MOV R7, #1              @ Send an exit request
    SVC 0                   @ Do a system call

lowercase:
    @ Exit function if R0 < 'A' then insert Link Register address in Program Counter
    CMP R0, #('A')
    MOVLT PC, LR

    @ Exit function if R0 > 'Z' then insert Link Register address in Program Counter
    CMP R0, #('Z')
    MOVGT PC, LR

    ADD R0, R0, #('a'-'A')  @ Convert lowercase character to uppercase
    MOV PC, LR              @ Exit function
    
.data
    input:      .asciz "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG\n"
    output:     .fill 255, 1, 0