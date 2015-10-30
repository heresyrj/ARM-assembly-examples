factorial:
    str lr, [sp, #-4]! //push lr onto the top of the stack
    str r4, [sp, #-4]! //push r4 onto the top of the stack
                        //stack is now 8 byte aligned
    mov r4, r0          //keep a copy of initial value of r0 in r4

    cmp r0, #0          
    bne is_nonzero
    mov r0, #1          //this is the return value
    b end
is_nonzero:
    sub r0, r0, #1
    bl factorial
    
    mov r1, r4
    mul r0, r0, r1
end:
    ldr r4, [sp], #+4
    ldr lr, [sp], #+4
    bx lr

