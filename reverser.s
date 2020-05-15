    # this is a smiple example for reversing
    # an array using x86_64 amd 64 assembly
    # use GAS (Gnu Assembler) to compile
    # The prototype is
    # void reverser( int32_t* dest, int32_t* src, int32_t num_elements )
    # In AMD 64 ABI the parameters are passed as:
    #    %rdi - dest
    #    %rsi - src
    #    %edx - num_elements
	.text                       # put this code in the .text section
	.globl	reverser            # label 'reverser'
	.type	reverser,@function  # indicate that this is a function

reverser:
	testl	%edx, %edx          # test if num_elements is zero
	je	.finish                 # jump to .finish if yes
	movl	%edx, %r8d          # move num_elements to %r8d register temporarily
	shlq	$2, %r8             # r8 = num_elements * 4
	decl	%edx                # num_elements -= 1
	xorl	%ecx, %ecx          # "j" = ecx = 0 (xor is the fastest way to zero a register)

.loop:
	movl	(%rsi,%rcx), %r9d   # r9 = src[j]
	movl	%edx, %eax          # eax = num_elements
	movl	%r9d, (%rdi,%rax,4) # dest[num_elements*4] = r9
	addq	$4, %rcx            # j += 4
	decl	%edx                # num_elements -= 1
	cmpq	%rcx, %r8           # is j== num_elements * 4 ?
	jne	.loop                   # no, jump back to .loop

.finish:
	retq                        # pop the return address from the stack pointer and jump
