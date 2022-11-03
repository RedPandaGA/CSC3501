.globl prog2

#your full name: Gavin Avery
#your LSU ID number: 89-878-0399

prog2:
	#push the stack pointer
	pushl %ebp
	#move it to the base of the stack
	movl %esp, %ebp
	#callee-save register push
	pushl %ebx
	#callee-save register push
	pushl %esi
	#return j - i + 2
	#get j and save to %eax (j)
	movl 12(%ebp), %eax
	#get i and subtract it from %eax (j - i)
	subl 8(%ebp), %eax
	#add 2 to %eax (j - i + 2)
	addl $2, %eax
	#Set 6 * (*k)
	#get *k pointer and save to %esi
	movl 16(%ebp), %esi
	#get the actual value at *k and save to %edx 
	movl (%esi), %edx
	#multiply the value in %edx by 3 via leal
	leal (%edx, %edx, 2), %edx
	#multiply the value of in %edx by 2 via shift
	sall $1, %edx
	#move the value of %edx into the memory pointed to by *k
	movl %edx, (%esi)
	#Set *l = a[0] + a[1] + a[2] + a[3] + a[4];
	#Set %edx to 0 so it can be used at the total
	movl $0, %edx
	#Set %ecx to 0 to be used as the index counter
	movl $0, %ecx
	#get the address of a[] and save to %esi
	movl 20(%ebp), %esi
.L4: 
	#add the value at a[%ecx] to %edx (total)
	addl (%esi, %ecx, 4), %edx
	#add 1 to %ecx (iterate the index counter by 1)
	addl $1, %ecx  
	#compare %ecx to 5 (index counter = 5?)
	cmpl $5, %ecx
	#if %ecx is not 5 then jump to .L4 (loop through)
	jne .L4
	#Get the address of *i
	movl 24(%ebp), %esi
	#Save %edx (total) to the memory address in %esi
	movl %edx, (%esi)
	#callee-save register pop
	popl %esi
	#callee-save register pop
	popl %ebx
	#pop the stack pointer
	popl %ebp
	ret
	