@ A program that asks the user 
@ for their input and stores it in a file.
@ The information in the file is overwritten

.data
    path:           .asciz "/home/pi/Desktop/Assembly/Exercises/data"
    msg:            .asciz "Input: "
    msgEnd:
    err:            .asciz "Oops, something went wrong... :/\n"
    errEnd:  
    buffer:         .fill   51, 1, 0

.text
.global _start

@ Symbolic links
.EQU    NA,         -1
.EQU    EXIT,       1
.EQU    READ,       3
.EQU    WRITE,      4
.EQU    OPEN,       5
.EQU    CLOSE,      6
.EQU    DELETE,     10
.EQU    LENGTH,     50

_start:
    BL delete                   @ Try to overwrite file - delete old (if exists) and create new
    @ Display input message
    MOV R7, #WRITE
    MOV R0, #1

    LDR R1, =msg
    MOV R2, #(msgEnd - msg)

    SVC 0                       @ System call

read:
    @ Get user input
    MOV R7, #READ
    MOV R0, #0

    LDR R1, =buffer
    MOV R2, #LENGTH
    SVC 0                       @ System call

    MOV R4, R0

    BL writeFile

@ Exit program
_end:
    BL close                    @ Call close file function

    MOV R7, #EXIT
    SVC 0                       @ System call

@ Functions

@ Delete file
delete:
    MOV R7, #DELETE             @ System call 10 for delete
    LDR R0, =path

    SVC 0                       @ System call

@ Open / Create file
openFile:
    MOV R7, #OPEN
    LDR R0, =path

    MOV R1, #0x42
    MOV R2, #384

    SVC 0                       @ System call

    CMP R0, #NA                 @ Check for errors
    BEQ error                   @ If R0 == -1 => branch to error

    MOV R10, R0                 @ Store field descriptor of file in R10

    MOV PC, LR                  @ Exit function

@ Write to file
writeFile:
    MOV R7, #WRITE
    MOV R0, R10                 @ Move field descriptor from R10 to R0
    
    LDR R1, =buffer
    MOV R2, R4

    SVC 0                       @ System call

    MOV PC, LR                  @ Exit function

@ Close file
close:
    @ Close file
    MOV R7, #CLOSE

    SVC 0

    MOV PC, LR                  @ Exit function

@ Display error message on the console
error:
    MOV R7, #WRITE
    MOV R0, #0

    LDR R1, =err
    MOV R2, #(errEnd - err)

    SVC 0                       @ Exit function

    B _end                      @ Exit program