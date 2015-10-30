//the calling function pass 2 parameters
// 1. num_elements 
// 2. array, containing 0~100 elements
// which effectively means pass the base address of the array
// Therefore, r0 <- num_elements
//            r1 <- base_address
//
//r0 - r3 scratch
//r4 - r9 retain value


//for Data
.data

//store the base address of array
.balign 4
base: .word 0 


//for code
.text
.global bubble 
bubble:
	push {r4-r8, lr} 
	//push lr(r14) to keep the value
	//will use r6 to store # of swaps

	//store the size of array
	mov r4, r0
    sub r4, r4, #1
	//store the base address in r5, an address
	// r1(address), r5 = base, *base = r1
	ldr r5, =base
	str r1, [r5]
	//initialize # of swaps
	mov r6, #0	
	
sort:
	//get the base address
	ldr r0, =base
	ldr r0, [r0]//now r0 is address of array base
	add r1, r0, #4 //r1 is the address of next element
	
	//initialize # of counter
	mov r7, #0	
	b swapping //start one run 
	//compare # of swaps with 0
anyswaps:
	cmp r6, #0
	//IF it's 0, branch to end
	beq end
    //ELSE
    //restore swaps to 0
    mov r6, #0
	//and go through the loop again
	b sort
 
.func swapping
swapping://take r0 and r1 as parameter
	
	//compare r7(counter) with r4(size)
	cmp r7, r4
	//IF r7 >= r4, meaning finishing one run
	//go back to check if swap happened
	beq anyswaps

	//ELSE
	mov r8, r1//keep r0
	//get the values assigned to r0, r1
    mov r2, r0//use r2 store address of first value
    mov r3, r1//use r3 store address of second value
	ldr r0, [r0]//r0 store the first value
	ldr r1, [r1]//r1 store the second value
	//swap IF r0 > r1
	cmp r0, r1
	bgt swapping2
	//ELSE increment the index
finishswp2:	
    mov r0, r8
	add r1, r0, #4
	//and increase the counter by 1
	add r7, r7, #1
	
	b swapping
.endfunc

swapping2:
    str r1, [r2]//store the second value into the first address
	str r0, [r3]//store the first value into the second address
    add r6, r6, #1 //swap +1
    b finishswp2

end:	
	mov r0, #0
	pop {r4-r8, lr}
	bx lr
	
