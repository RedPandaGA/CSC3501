.global check_cache

check_cache:
	#push the stack pointer
	pushl   %ebp
	#move it to the base of the stack
	movl    %esp,   %ebp
	#callee-save register push
	pushl %ebx
	#callee-save register push
	pushl %esi
	#get address 1 byte value
	movb	12(%ebp), %bl
	#get address 1 byte value
	movb	12(%ebp), %cl
	#get address 1 byte value
	movb	12(%ebp), %dl
	#filter it for the offset bits
	andb	$3, %bl
	#extend it to 4 byte fullsize 
	movzbl 	%bl, %ebx
	#filter it for the set bits
	andb	$12, %cl
	#reduce the value, get rid of 0s on the right
	shrb	$2, %cl
	#extend it to 4 byte fullsize 
	movzbl 	%cl, %ecx
	#filter it for the tag bits
	andb	$240, %dl
	#reduce the value, get rid of 0s on the right
	shrb	$4, %dl
	#get the address for the beginning of the cache
	movl	8(%ebp), %esi
	#multiply set by 3
	leal	(%ecx, %ecx, 2), %ecx
	#multiply set by 2, this is to get the proper offset to get the right cache line 
	sall	$1, %ecx
	#add the offset to the address which currently points to the beginning of the cache
	addl	%ecx, %esi
	#move the address to point to the line's valid byte
	addl	$4, %esi
	#store the value in the valid byte into eax
	movl	(%esi), %eax
	#test to see if eax == 1
	testl	$0x1, %eax
	#set eax to 0xFF, miss
	movl	$0xFF, %eax	
	#If eax != 1 then jump to the end skipping the rest
	je 		.E1
	# move the address to point to the tag byte
	addl	$1, %esi
	#grab the tag value
	movb	(%esi), %al
	#compare the tag value in the cache to the tag value in the address
	cmpb	%dl, %al
	#set eax to 0xFF, miss
	movl	$0xFF, %eax
	#If tag values are not equal jump to the end skipping the rest
	jne		.E1
	#reset the address to the beginning of the line
	subl 	$5, %esi
	#move the address to the right data block 
	addl    %ebx, %esi
	#set the return value to the block at the address
	movb	(%esi), %al
.E1:
	#callee-save register pop
	popl 	%esi
	#callee-save register pop
	popl 	%ebx
	#pop the stack pointer
	popl    %ebp
    ret
