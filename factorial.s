/*
int factorial(int n)
{
   if (n == 0)
      return 1;
   else
      return n * factorial(n-1);
}
*/

.data
msg1: .asciz "type a number "
format: .asciz "%d"
msg2: .asciz "the factorial of %d is %d\n"


.text

factorial:
    str lr, [sp, #-4]! 
    //pre-indexing, increase stack 4bytes by downward the sp 4 bytes in address
    //push lr onto the top of stack
    str r0, [sp, #-4]!
    //push r0 to the top of stack.
    //note now sp is 8 byte aligned
    cmp r0, #0
    bne is_nonzero
    mov r0, #1  // this is the return
    b end
is_nonzero:
                   //prepare to call the factoril (n-1)
    sub r0, r0, #1 //r0 = r0 -1
    bl factorial   //after the call, r0 contains factorial(n-1)
    ldr r1, [sp]   //load r1 (we kept in stack) into r1
    mul r0, r0, r1 //r0 = r0 * r1
end:
    add sp, sp, #+4   //discard the r0 we kept in the stack
    ldr lr, [sp], #+4 //pop the top of the stack and put it in lr
    bx lr             //leave factoral

.global main
main:
    str lr, [sp, #-4]! //push lr onto the top of the stack
    sub sp, sp, #4     //make room for one 4-byte integer in the stack
    ldr r0, =msg1      // r0 <- &msg1
    bl printf

    ldr r0, =format     //set format for scnf
    mov r1, sp          //set the top of the stack as the second parameter 
    bl scanf

    ldr r0, [sp]        //load the int read of scanf into r0

    bl factorial
    
    mov r2, r0          //get the result of the factorial and move it into r2
                        //so we set it as the third para of printf
    ldr r0, =msg2       
    bl printf
    
    add sp, sp, #+4     //discard the int read of scanf
    ldr lr, [sp], #+4   //pop the top fo the stack and put it in lr
    bx lr
