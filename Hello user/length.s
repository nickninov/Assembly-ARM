@ A macro that copies a set amount of
@ characters from input to destination

.MACRO  length  input destination num

1:
    LDR R0, =\input             @ Load R0 with input address
    LDR R1, =\destination       @ Load R1 with destination address
    MOV R2, #0                  @ R2 - counter for recursion
    MOV R3, #(\num -1)          @ R3 - the total amount of repetitions

2:
    LDRB R4, [R0], #1           @ Load character from input and increment memory
    STRB R4, [R1], #1           @ Store character in destination and increment memory

    ADD R2, #1                  @ Increment R2 counter
    CMP R2, R3                  @ Check if R2 == R3
    BNE 2b                      @ If R2 != R3 repeat

.ENDM