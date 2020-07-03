.include "print.s"

.global _start

_start:
    @ Cast macro on different length strings
    print str1
    print str2
    print str3
    print str4
    print str5
    print str6

_end:
    MOV R7, #1      @ Send an exit request
    SVC 0           @ Do a system call

.data
    str1:       .asciz  "Star Wars I: The Phantom Menace\n"
    str2:       .asciz  "Star Wars II: Attack Of The Clones\n"
    str3:       .asciz  "Star Wars III: Revenge Of The Sith\n"
    str4:       .asciz  "Star Wars IV: A New Hope\n" 
    str5:       .asciz  "Star Wars V: The Empire Strikes Back\n"
    str6:       .asciz  "Star Wars VI: The Return Of The Jedi\n"