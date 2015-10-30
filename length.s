//data section
.data

.balign 4
string: .skip 400

.balign 4
scan_pattern: .asciz "%s"

.balign 4
out_pattern: .asciz "%d"

.balign 4
return: .word 0

.balign 4
counter: .word 0

        
//code section
.text

.global main
main:
    //store lr
    ldr r1, ad_of_return
    str lr, [r1]

    //read the string from stdin
    ldr r0, ad_of_scanp
    ldr r1, ad_of_string
    bl scanf
    
    ldr r0, ad_of_string 
    ldr r1, ad_of_counter //get the ad of counter in r2
    ldr r1, [r1]    

loop:
    ldr r4, [r0] //get the integer value of r0
    cmp r4, #0
    beq result
    
    //move to next character(byte)
    add r0, r0, #1    //increment add by 1

    //update counter value    
    add r1, r1, #1  //increment 1 every time
    
    b loop

result:
    //store value in counter
    //ldr r2 ad_of_counter
    //str r1 [r2]
    
    //print
    ldr r0, ad_of_outp
    //ldr r1, ad_of_counter
    //ldr r1, [r1]
    bl printf

end:
    //restore r1
    ldr r1, ad_of_return
    ldr lr, [r1]
    bx lr

ad_of_string: .word string
ad_of_scanp: .word scan_pattern
ad_of_return: .word return
ad_of_counter: .word counter
ad_of_outp: .word out_pattern
//external
.global scanf
.global printf
.global puts
