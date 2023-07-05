	.file	"asgn1.c"								# source file name							

	.text										# code starts

	.section	.rodata									# read only data section

	.align 8										# align with 8-byte boundary

.LC0:											# Label of string 1st printf

	.string	"Enter the string (all lowrer case): "

.LC1:											# Label of string scanf

	.string	"%s"

.LC2:											# Label of string 2nd printf

	.string	"Length of the string: %d\n"

	.align 8										# align with 8-byte boundary

.LC3:											# Label of f-string-3rd printf

	.string	"The string in descending order: %s\n"	

	.text									

	.globl	main									# main is a global name


	.type	main, @function								# main is a function:

main:											# main: starts

.LFB0:	
	.cfi_startproc

	endbr64

	pushq	%rbp									# save old base pointer

	.cfi_def_cfa_offset 16

	.cfi_offset 6, -16

	movq	%rsp, %rbp								# rbp <-- rsp set new stack base pointer

	.cfi_def_cfa_register 6

	subq	$80, %rsp								# Create space for local array and variables
	
	movq	%fs:40, %rax								# Segment addressing

	movq	%rax, -8(%rbp)								# M[rbp-8] <-- rax

	xorl	%eax, %eax								# eax <-- 0 
	
	leaq	.LC0(%rip), %rax								# rax <-- (rip+.LC0) Load address of string of the 1st printf 

	movq	%rax, %rdi								# rdi <-- rax 

	movl	$0, %eax									# eax <-- 0

	call	printf@PLT								# calls the printf statement to print 1st statement

	leaq	-64(%rbp), %rax								# rax <-- (rbp-64) loading register value of rbp-64 into rax 

	movq	%rax, %rsi								# rsi <-- rax 

	leaq	.LC1(%rip), %rax								# rax <-- (rip+.LC1) Load address to store parameter 

	movq	%rax, %rdi								# rdi <-- rax

	movl	$0, %eax									# eax <-- 0

	call	__isoc99_scanf@PLT							# calls the scanf statement to get input

	leaq	-64(%rbp), %rax								# rax <-- (rbp-64) (&terms) copying the register value of rbp-64 into

											# rax, i.e. address of str is stored in register rax

	movq	%rax, %rdi								# rdi <-- str , copying the address of str into rdi 


	call	length									# calls the length function

	movl	%eax, -68(%rbp)								# len <-- eax i.e. M[rbp-68] <-- eax

	movl	-68(%rbp), %eax								# eax <-- M[rbp-68] i.e. eax <-- len

	movl	%eax, %esi								# esi <-- eax i.e esi <-- len

	leaq	.LC2(%rip), %rax								# rax <-- (rip+.LC2) Load address of string of the 2nd printf

	movq	%rax, %rdi								# rdi <-- rax

	movl	$0, %eax									# eax <-- 0

	call	printf@PLT								# calls printf function to print 2nd statement

	leaq	-32(%rbp), %rdx								# rdx <-- (rbp-32) (&terms) i.e. rdx <-- dest , storing address of dest

	movl	-68(%rbp), %ecx								# ecx <-- M[rbp-68] i.e. ecx <-- len

	leaq	-64(%rbp), %rax								# rax <-- (rbp-64) (&terms) i.e. rax <-- str ,storing address of str

	movl	%ecx, %esi								# esi <-- ecx i.e esi <-- len

	movq	%rax, %rdi								# rdi <-- str, storing address of pointer to str in rdi

	call	sort									# calls the sort function 

	leaq	-32(%rbp), %rax								# rax <-- (rbp-32) (&terms) i.e rax <-- dest, storing address of dest

	movq	%rax, %rsi								# rsi <-- rax, i.e. rsi <-- dest
	
	leaq	.LC3(%rip), %rax								# rax <-- (rip+.LC3) Load address of string of 3rd printf

	movq	%rax, %rdi								# rdi <-- rax

	movl	$0, %eax									# eax <-- 0

	call	printf@PLT								# calls the printf statement to print 3rd printf

	movl	$0, %eax									# eax <-- 0

	movq	-8(%rbp), %rdx								# rdx <-- M[rbp-8] 


	subq	%fs:40, %rdx								# flag ZF is computed

	je	.L3									# jump if ZF==0 L3

	call	__stack_chk_fail@PLT							# calls it when stack overflows
.L3:
	leave										# clear stack

	.cfi_def_cfa 7, 8

	ret										# return

	.cfi_endproc									# end program
.LFE0:

	.size	main, .-main

	.globl	length									# length is a global name

	.type	length, @function							# length is a function:


length:											# length: starts
.LFB1:
	.cfi_startproc

	endbr64

	pushq	%rbp									# save old base pointer

	.cfi_def_cfa_offset 16	

	.cfi_offset 6, -16

	movq	%rsp, %rbp								# new temporary stack base pointer 

	.cfi_def_cfa_register 6

	movq	%rdi, -24(%rbp)								# M[rbp-24] <-- str , storing address of str in M[rbp-24]

	movl	$0, -4(%rbp)								# i <-- 0 i.e. M[rbp-4] <-- 0

	jmp	.L5									# jump to .L5
.L6:
	addl	$1, -4(%rbp)								# i <-- i + 1
.L5:

	movl	-4(%rbp), %eax								# eax <-- i i.e. eax <-- M[rbp-4]

	movslq	%eax, %rdx								# rdx <-- sign extended i 

	movq	-24(%rbp), %rax								# rax <-- str i.e. rax <-- M[rbp-24]

	addq	%rdx, %rax								# rax <- str + i

	movzbl	(%rax), %eax								# eax <-- M[str+i] 										

	testb	%al, %al									# performs bitwise and on al with al, where al is least significant byte 

											# of eax, ZF is computed 
	
	jne	.L6									# if ZF!=1 then go to .L6

	movl	-4(%rbp), %eax								# eax <-- i 

	popq	%rbp									# pop return address

	.cfi_def_cfa 7, 8		

	ret										# return control to caller

	.cfi_endproc
.LFE1:
	.size	length, .-length

	.globl	sort									# sort is a global name

	.type	sort, @function								# sort is a function

sort:											# sort starts
.LFB2:

	.cfi_startproc

	endbr64

	pushq	%rbp									# save old base pointer

	.cfi_def_cfa_offset 16

	.cfi_offset 6, -16

	movq	%rsp, %rbp								# new temporary stack base pointer

	.cfi_def_cfa_register 6


	
	subq	$48, %rsp								# creating space for local variables

	movq	%rdi, -24(%rbp)								# M[rbp-24] <-- str, storing address of str

	movl	%esi, -28(%rbp)								# M[rbp-28] <-- len

	movq	%rdx, -40(%rbp)								# M[rbp-40] <-- dest, storing address of dest

	movl	$0, -8(%rbp)								# i <-- 0

	jmp	.L9									# jump to .L9

.L13:

	movl	$0, -4(%rbp)								# j <-- 0

	jmp	.L10									# jump to .L10


.L12:

	movl	-8(%rbp), %eax								# eax <-- i

	movslq	%eax, %rdx								# rdx <-- sign extended i 
	
	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e. rax <-- str

	addq	%rdx, %rax								# rax <-- str + i

	movzbl	(%rax), %edx								# edx <-- M[str+i], copy the low 8 bits from src to dest

											# (here movzbl src dest) other than low 8 bits make other bits zero

	movl	-4(%rbp), %eax								# eax <-- j

	movslq	%eax, %rcx								# rcx <-- sign extended j 

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e. rax <-- str

	addq	%rcx, %rax								# rax <-- str + j

	movzbl	(%rax), %eax								# eax <-- M[str+j], copy the low 8 bits from src to dest

											# ( here movzbl src dest), other than low 8 bits make other bits zero

	cmpb	%al, %dl									# if M[str+i] >= M[str+j]

	jge	.L11									# go to .L11

	movl	-8(%rbp), %eax								# eax <-- i

	movslq	%eax, %rdx								# rdx <-- sign extended i 

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e. rax <-- str

	addq	%rdx, %rax								# rax <-- str+i

	movzbl	(%rax), %eax								# eax <-- M[str+i], copy the low 8 bits from src to dest

											# ( here movzbl src dest), other than low 8 bits make other bits zero

	movb	%al, -9(%rbp)								# M[rbp-9] <-- al i.e. temp <-- al  

	movl	-4(%rbp), %eax								# eax <-- j

	movslq	%eax, %rdx								# rdx <-- sign extended j 

	movq	-24(%rbp), %rax								# rax <-- str

	addq	%rdx, %rax								# rax <-- str + j

	movl	-8(%rbp), %edx								# edx <-- i

	movslq	%edx, %rcx								# rcx <-- sign extended i 

	movq	-24(%rbp), %rdx								# rdx <-- str

	addq	%rcx, %rdx								# rdx <-- str + i

	movzbl	(%rax), %eax								# eax <-- M[str+i], copy the low 8 bits from src to dest

											# ( here movzbl src dest) other than low 8 bits make other bits zero

	movb	%al, (%rdx)								# M[str+i] <-- al 

	movl	-4(%rbp), %eax								# eax <-- j

	movslq	%eax, %rdx								# rdx <-- sign extended j 

	movq	-24(%rbp), %rax								# rax <-- str

	addq	%rax, %rdx								# rdx <-- str + j

	movzbl	-9(%rbp), %eax								# eax <-- M[rbp-9] i.e. eax <-- temp

	movb	%al, (%rdx)								# M[str+j] <-- al

.L11:

	addl	$1, -4(%rbp)								# j <-- j + 1

.L10:

	movl	-4(%rbp), %eax								# eax <-- j i.e. eax <-- M[rbp-4]

	cmpl	-28(%rbp), %eax								# if j < len

	jl	.L12									# go to .L12

	addl	$1, -8(%rbp)								# i <-- i + 1


.L9:

	movl	-8(%rbp), %eax								# eax <-- M[rbp-8] i.e eax <-- i

	cmpl	-28(%rbp), %eax								# if i < len 

	jl	.L13									# go to .L13

	movq	-40(%rbp), %rdx								# rdx <-- M[rbp-40] i.e. rdx <-- dest, storing dest address

	movl	-28(%rbp), %ecx								# ecx <-- M[rbp-28] i.e. ecx <-- len

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e. rax <-- str, storing str address

	movl	%ecx, %esi								# esi <-- ecx i.e. esi <-- len

	movq	%rax, %rdi								# rdi <-- rax i.e. rdi <-- str, storing str address

	call	reverse									# calls the reverse function

	nop										# used to generate a delay in execution or to reserve space in code memory

	leave										# clear stack							

	.cfi_def_cfa 7, 8

	ret										# return to caller

	.cfi_endproc

.LFE2:

	.size	sort, .-sort							

	.globl	reverse									# reverse is a global name

	.type	reverse, @function							# reverse is a function 

reverse:											# reverse starts

.LFB3:		

	.cfi_startproc

	endbr64									

	pushq	%rbp									# save old base pointer

	.cfi_def_cfa_offset 16

	.cfi_offset 6, -16

	movq	%rsp, %rbp								# new temporary stack base pointer

	.cfi_def_cfa_register 6

	movq	%rdi, -24(%rbp)								# M[rbp-24] <-- rdi	i.e M[rbp-24] <-- str

	movl	%esi, -28(%rbp)								# M[rbp-28] <-- esi i.e M[rbp-28] <-- len

	movq	%rdx, -40(%rbp)								# M[rbp-40] <-- rdx i.e M[rbp-40] <-- dest

	movl	$0, -8(%rbp)								# M[rbp-8] <-- 0 i.e. i <-- 0

	jmp	.L15									# jump to .L15


.L20:

	movl	-28(%rbp), %eax								# eax <-- len

	subl	-8(%rbp), %eax								# eax <-- eax - i

	subl	$1, %eax									# eax <-- eax - 1

	movl	%eax, -4(%rbp)								# j <-- eax

	nop										# used to generate a delay in execution or to reserve space in code memory

	movl	-28(%rbp), %eax								# eax <-- len

	movl	%eax, %edx								# edx <-- len

	shrl	$31, %edx								# edx <-- len >> 31, we get signed bit

	addl	%edx, %eax								# eax <-- len + sign bit

	sarl	%eax									# eax <-- eax >> 1

	cmpl	%eax, -4(%rbp)								# if j < len/2

	jl	.L18									# go to .L18 

	movl	-8(%rbp), %eax								# eax <-- i

	cmpl	-4(%rbp), %eax								# if i == j

	je	.L23									# go to .L23

	movl	-8(%rbp), %eax								# eax <-- i

	movslq	%eax, %rdx								# rdx <-- sign extended i 

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e. rax <-- str

	addq	%rdx, %rax								# rax <-- rax + i i.e rax <-- str+i

	movzbl	(%rax), %eax								# copy the  low 8 bits from src to dest ( here movzbl src dest), 

											# other than low 8 bits make other bits zero

	movb	%al, -9(%rbp)								# temp <-- M[str+i]

	movl	-4(%rbp), %eax								# eax <-- j

	movslq	%eax, %rdx								# rdx <-- sign extended j 

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e rax <-- str 

	addq	%rdx, %rax								# rax <-- rax + j i.e rax <-- str+j

	movl	-8(%rbp), %edx								# edx <-- i

	movslq	%edx, %rcx								# rcx <-- sign extended i 

	movq	-24(%rbp), %rdx								# rdx <-- M[rbp-24] i.e rdx <-- str

	addq	%rcx, %rdx								# rdx <-- rdx + i i.e rdx <-- str+i

	movzbl	(%rax), %eax								# eax <-- M[str+j], copy the low 8 bits from src to dest 

											# (here movzbl src dest) other than low 8 bits make other bits zero 

	movb	%al, (%rdx)								# M[str+i] <-- al

	movl	-4(%rbp), %eax								# eax <-- j

	movslq	%eax, %rdx								# rdx <-- sign extended j 

	movq	-24(%rbp), %rax								# rax <-- M[rbp-24] i.e rax <-- str

	addq	%rax, %rdx								# rdx <-- rax + j i.e. rdx <-- str+j

	movzbl	-9(%rbp), %eax								# eax <-- temp, copy the low 8 bits from src to dest( here movzbl src dest)

											# other than low 8 bits make other bits zero 

	movb	%al, (%rdx)								# M[str+j] <-- al, here al contains value of temp

	jmp	.L18									# jump to .L18

.L23:

	nop										# used to generate a delay in execution or to reserve space in code memory

.L18:

	addl	$1, -8(%rbp)								# i <-- i+1

.L15:

	movl	-28(%rbp), %eax								# eax <-- M[rbp-28] i.e eax <-- len

	movl	%eax, %edx								# edx <-- len

	shrl	$31, %edx								# edx <-- len >> 31 , we get sign bit

	addl	%edx, %eax								# eax <-- len + sign bit	

	sarl	%eax									# eax <-- eax >> 1

	cmpl	%eax, -8(%rbp)								# if i < len/2 

	jl	.L20									# go to .L20

	movl	$0, -8(%rbp)								# i <-- 0

	jmp	.L21									# jump to .L21

.L22:

	movl	-8(%rbp), %eax								# eax <-- i

	movslq	%eax, %rdx								# rdx <-- sign extended i 

	movq	-24(%rbp), %rax								# rax <-- str

	addq	%rdx, %rax								# rax <-- str + i

	movl	-8(%rbp), %edx								# edx <-- i

	movslq	%edx, %rcx								# rcx <-- sign extended i 

	movq	-40(%rbp), %rdx								# rdx <-- dest

	addq	%rcx, %rdx								# rdx <-- dest + i

	movzbl	(%rax), %eax								# eax <-- M[dest+i], copy the low 8 bits from src to dest 

											# (here movzbl src dest) other than low 8 bits make other bits zero 

	movb	%al, (%rdx)								# M[dest+i] <-- al

	addl	$1, -8(%rbp)								# i <-- i + 1

.L21:

	movl	-8(%rbp), %eax								# eax <-- i


	cmpl	-28(%rbp), %eax								# if i < len 

	jl	.L22									# go to .L22

	nop										# used to generate a delay in execution or to reserve space in code memory

	nop										# used to generate a delay in execution or to reserve space in code memory

	popq	%rbp									# pop return address

	.cfi_def_cfa 7, 8

	ret										# return to caller

	.cfi_endproc

.LFE3:

	.size	reverse, .-reverse

	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"

	.section	.note.GNU-stack,"",@progbits

	.section	.note.gnu.property,"a"

	.align 8

	.long	1f - 0f

	.long	4f - 1f

	.long	5

0:
	.string	"GNU"

1:
	.align 8

	.long	0xc0000002

	.long	3f - 2f

2:
	.long	0x3

3:
	.align 8

4: