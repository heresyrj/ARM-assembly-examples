/* Summary */

//data declaration
.data

.balign 4
num: .word 0 //store the num read in stdout

.balign 4
pattern: .asciz "%d" //format pattern of scan

.balign 4
return: .word 0 //store lr


//code section
.text

.global main
main:
    //store lr
    ldr r1, ad_of_return//load address of return to r5    
    str lr, [r1]        //put lr as the value pointed by r5

    //load pointers to registers
    
    //set r6 as sum
    mov r6, #0
    //set r7 as counter
    mov r7, #0
sum:
    cmp r7, #5
    beq print
    
    ldr r0, ad_of_p //load address of scan pattern 
    ldr r1, ad_of_num //load address of first number read
    bl scanf //take r0, r1 as parameters
    
    ldr r2, ad_of_num
    ldr r2, [r2]      
    add r6, r6, r2 //increment every time
        
    add r7, r7, #1

    b sum  

print:
    ldr r0, ad_of_p
    mov r1, r6
    bl printf    

end:
    //restore lr
    ldr r1, ad_of_return
    ldr lr, [r1]
    bx lr

ad_of_num: .word num
ad_of_p: .word pattern
ad_of_return: .word return

//external func
.global scanf
.global printf
