@ A macro that prints out a string

.MACRO  print   str
    LDR R3, = \str          @ Load message to register

1:
    LDRB R4, [R3], #1       @ Load character from str and increment memory

    CMP R4, #0              @ Check if R4 has reached the end of the string
    BNE 1b                  @ If R4 is not 0 then go backwards one label

2:
    MOV R0, #1              @ Write on screen
    MOV R7, #4              @ Send a write request

    LDR R1, = \str          @ Load message to register
    SUB R2, R3, R1          @ Get the total length of the string

    SVC 0                   @ Do a system call

.ENDM