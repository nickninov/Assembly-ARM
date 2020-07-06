@ Collatz Conjecture
@ If n is even => n / 2
@ If n is odd => 3 * n + 1
@ Result is always 1

@ R0 - selected number
@ R1 - store result of R0 AND 1
@ R2 - temporarily store R0 * 2

.text
.global _start

_start:
    MOV R0, #250

@ Initialize loop
loop:
    @ Check if program should terminate
    CMP R0, #1          @ Check if R0 has reached 1
    BEQ _end            @ If R0 == 1 then exit program

    @ Check if number is even or odd
    AND R1, R0, #1      @ Store the result of R0 AND 1 in R1
    CMP R1, #1          @ Check if R1 is 1
    BLEQ odd            @ If R1 == 1 then number is odd
    BLNE even           @ If R1 != 1 then number is even

    B loop              @ Iterate again

@ End program
_end:
    MOV R7, #1          @ Send an exit request
    SVC 0               @ Do a system call

@ Functions

@ n / 2
even:
    LSR R0, R0, #1
    MOV PC, LR          @ Go back 

@ 3 * n + 1
odd:
    @ 3 * n
    LSL R2, R0, #1      @ 2 * n
    ADD R0, R2, R0      @ (2 * n) + n

    @ + 1
    ADD R0, R0, #1      @ ((2 * n) + n) + 1
    MOV PC, LR