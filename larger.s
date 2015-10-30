/* Larger */

//data declaration
.data

.balign 4
num1: .word 0 //store the first num read in stdout
.balign 4
num2: .word 0 //store the second num read in stdout

.balign 4
scan_pattern: .asciz "%d" //format pattern of scan

.balign 4
return: .word 0 //store lr


//code section
.text

.global main
main:
    //store lr
    ldr r1, ad_of_return//load address of return to r5    
    str lr, [r1]        //put lr as the value pointed by r5

    //read the numers to be compared
    ldr r0, ad_of_scanp //load address of scan pattern
    ldr r1, ad_of_num1  //load address of first number read
    bl scanf

    ldr r0, ad_of_scanp //load address of scan pattern
    ldr r1, ad_of_num2  //load address of second number read
    bl scanf    
    
    //load values to compare
    ldr r0, ad_of_num1
    ldr r0, [r0]
    ldr r1, ad_of_num2
    ldr r1, [r1]

    //compare numbers read
    cmp r0, r1
    ble second_is_greater
    
    //ldr r0, ad_of_scanp
    ldr r0, ad_of_scanp
    ldr r1, ad_of_num1
    ldr r1, [r1]
    bl printf

    b end

second_is_greater: 
    ldr r0, ad_of_scanp
    ldr r1, ad_of_num2
    ldr r1, [r1]
    bl printf
end:
    //restore lr
    ldr r1, ad_of_return
    ldr lr, [r1]
    bx lr

ad_of_num1: .word num1
ad_of_num2: .word num2
ad_of_scanp: .word scan_pattern
ad_of_return: .word return

//external func
.global scanf
.global printf
