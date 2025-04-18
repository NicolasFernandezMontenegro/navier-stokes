	.file	"solver.c"
	.text
	.p2align 4
	.type	lin_solve_rb_step.constprop.0, @function
lin_solve_rb_step.constprop.0:
.LFB5500:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leal	2(%rdi), %r8d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	shrl	%r8d
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	vmovss	.LC0(%rip), %xmm2
	andq	$-32, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -4(%rsp)
	vdivss	%xmm1, %xmm2, %xmm1
	testl	%edi, %edi
	je	.L12
	leal	-1(%r8), %eax
	movq	%rsi, %r13
	movq	%rcx, %r9
	movq	%rdx, %rsi
	movl	%eax, -8(%rsp)
	movl	%r8d, %eax
	movl	$1, %r14d
	movl	$-1, %ebx
	movl	$1, %r15d
	movq	%rax, -16(%rsp)
	vbroadcastss	%xmm0, %ymm3
	vbroadcastss	%xmm1, %ymm1
	.p2align 4
	.p2align 3
.L3:
	movl	-8(%rsp), %eax
	leal	(%r14,%rax), %r12d
	cmpl	%r14d, %r12d
	jbe	.L6
	movl	%r15d, %r11d
	imulq	-16(%rsp), %r11
	movl	%r14d, %ecx
	.p2align 4
	.p2align 3
.L4:
	movl	%ecx, %eax
	addl	$8, %ecx
	addq	%r11, %rax
	movslq	%eax, %rdx
	leal	(%rbx,%rax), %edi
	leal	(%r8,%rax), %r10d
	subl	%r8d, %eax
	salq	$2, %rdx
	vmovups	(%rsi,%r10,4), %ymm0
	vmovups	(%rsi,%rax,4), %ymm4
	movslq	%edi, %rdi
	vaddps	(%rsi,%rdi,4), %ymm0, %ymm0
	vaddps	(%rsi,%rdx), %ymm4, %ymm2
	vaddps	%ymm2, %ymm0, %ymm0
	vfmadd213ps	0(%r13,%rdx), %ymm3, %ymm0
	vmulps	%ymm1, %ymm0, %ymm0
	vextractf128	$0x1, %ymm0, 16(%r9,%rdx)
	vmovups	%xmm0, (%r9,%rdx)
	cmpl	%r12d, %ecx
	jb	.L4
.L6:
	movl	$1, %eax
	incl	%r15d
	negl	%ebx
	subl	%r14d, %eax
	movl	%eax, %r14d
	cmpl	%r15d, -4(%rsp)
	jnb	.L3
	vzeroupper
.L12:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5500:
	.size	lin_solve_rb_step.constprop.0, .-lin_solve_rb_step.constprop.0
	.p2align 4
	.type	lin_solve_rb_step.constprop.1, @function
lin_solve_rb_step.constprop.1:
.LFB5501:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leal	2(%rdi), %r8d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	shrl	%r8d
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	vmovss	.LC0(%rip), %xmm2
	andq	$-32, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -4(%rsp)
	vdivss	%xmm1, %xmm2, %xmm1
	testl	%edi, %edi
	je	.L26
	leal	-1(%r8), %eax
	movq	%rsi, %r13
	movq	%rcx, %r9
	movq	%rdx, %rsi
	movl	%eax, -8(%rsp)
	movl	%r8d, %eax
	xorl	%r14d, %r14d
	movl	$1, %ebx
	movl	$1, %r15d
	movq	%rax, -16(%rsp)
	vbroadcastss	%xmm0, %ymm3
	vbroadcastss	%xmm1, %ymm1
	.p2align 4
	.p2align 3
.L17:
	movl	-8(%rsp), %eax
	leal	(%r14,%rax), %r12d
	cmpl	%r14d, %r12d
	jbe	.L20
	movl	%r15d, %r11d
	imulq	-16(%rsp), %r11
	movl	%r14d, %ecx
	.p2align 4
	.p2align 3
.L18:
	movl	%ecx, %eax
	addl	$8, %ecx
	addq	%r11, %rax
	movslq	%eax, %rdx
	leal	(%rbx,%rax), %edi
	leal	(%r8,%rax), %r10d
	subl	%r8d, %eax
	salq	$2, %rdx
	vmovups	(%rsi,%r10,4), %ymm0
	vmovups	(%rsi,%rax,4), %ymm4
	movslq	%edi, %rdi
	vaddps	(%rsi,%rdi,4), %ymm0, %ymm0
	vaddps	(%rsi,%rdx), %ymm4, %ymm2
	vaddps	%ymm2, %ymm0, %ymm0
	vfmadd213ps	0(%r13,%rdx), %ymm3, %ymm0
	vmulps	%ymm1, %ymm0, %ymm0
	vextractf128	$0x1, %ymm0, 16(%r9,%rdx)
	vmovups	%xmm0, (%r9,%rdx)
	cmpl	%r12d, %ecx
	jb	.L18
.L20:
	movl	$1, %eax
	incl	%r15d
	negl	%ebx
	subl	%r14d, %eax
	movl	%eax, %r14d
	cmpl	%r15d, -4(%rsp)
	jnb	.L17
	vzeroupper
.L26:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5501:
	.size	lin_solve_rb_step.constprop.1, .-lin_solve_rb_step.constprop.1
	.p2align 4
	.type	set_bnd.constprop.1, @function
set_bnd.constprop.1:
.LFB5502:
	.cfi_startproc
	movl	%edi, %eax
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %rcx
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leal	2(%rax), %r14d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rax, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rax, %rbx
	movq	%r14, %r11
	shrq	%rbx
	shrq	%r11
	movq	%rax, -16(%rsp)
	movq	%r14, %rbp
	movq	%rbx, -40(%rsp)
	leal	1(%rax), %ebx
	movl	$1, %r8d
	vmovss	.LC2(%rip), %xmm1
	movq	%rbx, %r15
	imulq	%r11, %rax
	movq	%rbx, %r13
	movq	%rbx, -8(%rsp)
	imulq	%r11, %rbx
	shrq	%r15
	imulq	%r11, %rbp
	movq	%rax, -32(%rsp)
	movq	%rbx, -24(%rsp)
	testl	%r12d, %r12d
	je	.L30
	.p2align 4
	.p2align 3
.L29:
	movl	%r8d, %edi
	movl	%r8d, %esi
	movl	%r8d, %r10d
	notl	%edi
	movq	%rsi, %r9
	andl	$1, %r10d
	andl	$1, %edi
	imulq	%r11, %r9
	imulq	%r14, %rdi
	imulq	%rbp, %r10
	leaq	(%rsi,%rdi), %rax
	imulq	%r11, %rdi
	shrq	%rsi
	imulq	%r11, %rax
	leaq	(%r9,%r10), %rdx
	addq	%rsi, %r10
	vmovss	(%rcx,%rax,4), %xmm0
	movl	%r8d, %eax
	xorl	%r13d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%r9,%rax), %rbx
	addq	%rsi, %rax
	addq	-24(%rsp), %rax
	addq	%r15, %rbx
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rdx,4)
	movl	%r12d, %edx
	xorl	%r8d, %edx
	incl	%r8d
	andl	$1, %edx
	imulq	%rbp, %rdx
	addq	%rdx, %r9
	addq	-40(%rsp), %r9
	addq	%rsi, %rdx
	addq	-32(%rsp), %rdx
	vmovss	(%rcx,%r9,4), %xmm0
	leaq	(%rsi,%r11), %r9
	addq	%rdi, %r9
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rbx,4)
	vmovss	(%rcx,%r9,4), %xmm0
	vmovss	%xmm0, (%rcx,%r10,4)
	vmovss	(%rcx,%rdx,4), %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	cmpl	%r8d, %r12d
	jnb	.L29
.L30:
	leaq	(%r11,%rbp), %rax
	vmovss	.LC1(%rip), %xmm1
	movl	%r13d, %esi
	movl	%r12d, %edx
	vmovss	(%rcx,%rax,4), %xmm0
	notl	%esi
	movq	-8(%rsp), %rbx
	andl	$1, %edx
	vaddss	(%rcx,%rbp,4), %xmm0, %xmm0
	andl	$1, %esi
	movq	-16(%rsp), %r8
	imulq	%r14, %rdx
	imulq	%r14, %rsi
	leaq	0(,%r11,4), %r9
	movl	%r13d, %eax
	xorl	%r12d, %r13d
	andl	$1, %eax
	andl	$1, %r13d
	imulq	%r14, %rax
	leaq	(%rsi,%rbx), %r10
	imulq	%r11, %rsi
	addq	%rdx, %r8
	imulq	%r9, %r10
	imulq	%r9, %r8
	leaq	(%rax,%rbx), %rdi
	movq	-40(%rsp), %rbx
	imulq	%r9, %rdi
	imulq	%r11, %rdx
	imulq	%r11, %rax
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%rbp, %r13
	addq	%rbx, %rdx
	addq	%r15, %rax
	vmovss	%xmm0, (%rcx)
	vmovss	(%rcx,%r10), %xmm0
	vaddss	(%rcx,%r8), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rdi)
	leaq	(%r11,%r15), %rdi
	addq	%rdi, %rsi
	vmovss	(%rcx,%rsi,4), %xmm0
	movq	-24(%rsp), %rsi
	vaddss	(%rcx,%rdx,4), %xmm0, %xmm0
	leaq	(%r15,%rsi), %rdx
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	movq	%rbx, %rax
	addq	%r13, %rax
	addq	%r15, %r13
	addq	-32(%rsp), %r13
	addq	%rsi, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	vmovss	(%rcx,%rax,4), %xmm0
	popq	%r12
	.cfi_def_cfa_offset 32
	vaddss	(%rcx,%r13,4), %xmm0, %xmm0
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rdx,4)
	ret
	.cfi_endproc
.LFE5502:
	.size	set_bnd.constprop.1, .-set_bnd.constprop.1
	.p2align 4
	.type	set_bnd.constprop.2, @function
set_bnd.constprop.2:
.LFB5503:
	.cfi_startproc
	movl	%edi, %eax
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %rcx
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leal	2(%rax), %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leal	1(%rax), %esi
	movq	%r13, %r11
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %r14
	shrq	%r11
	movq	%rax, %rbx
	movq	%rax, %rbp
	movq	%rax, -16(%rsp)
	movq	%rsi, %r12
	imulq	%r11, %rax
	movq	%rsi, -8(%rsp)
	shrq	%rbx
	imulq	%r11, %rsi
	movq	%rbx, -32(%rsp)
	movq	%r13, %rbx
	shrq	%r14
	imulq	%r11, %rbx
	movl	$1, %r8d
	movq	%rax, -24(%rsp)
	movq	%rsi, %r15
	testl	%ebp, %ebp
	je	.L38
	.p2align 4
	.p2align 3
.L37:
	movl	%r8d, %edi
	movl	%r8d, %esi
	movl	%r8d, %r10d
	movl	%ebp, %edx
	notl	%edi
	movq	%rsi, %r9
	xorl	%r8d, %edx
	andl	$1, %r10d
	andl	$1, %edi
	imulq	%r11, %r9
	andl	$1, %edx
	imulq	%r13, %rdi
	imulq	%rbx, %r10
	imulq	%rbx, %rdx
	leaq	(%rsi,%rdi), %rax
	imulq	%r11, %rdi
	shrq	%rsi
	imulq	%r11, %rax
	vmovss	(%rcx,%rax,4), %xmm0
	leaq	(%r9,%r10), %rax
	addq	%rsi, %r10
	vmovss	%xmm0, (%rcx,%rax,4)
	leaq	(%r9,%rdx), %rax
	addq	-32(%rsp), %rax
	addq	%rsi, %rdx
	addq	-24(%rsp), %rdx
	vmovss	(%rcx,%rax,4), %xmm0
	movl	%r8d, %eax
	incl	%r8d
	xorl	%r12d, %eax
	andl	$1, %eax
	imulq	%rbx, %rax
	addq	%rax, %r9
	addq	%rsi, %rax
	addq	%r14, %r9
	addq	%r15, %rax
	vmovss	%xmm0, (%rcx,%r9,4)
	leaq	(%rsi,%r11), %r9
	addq	%rdi, %r9
	vmovss	(%rcx,%r9,4), %xmm0
	vmovss	%xmm0, (%rcx,%r10,4)
	vmovss	(%rcx,%rdx,4), %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	cmpl	%r8d, %ebp
	jnb	.L37
.L38:
	leaq	(%r11,%rbx), %rax
	movl	%r12d, %esi
	movq	-8(%rsp), %r8
	movl	%ebp, %edx
	vmovss	(%rcx,%rax,4), %xmm0
	notl	%esi
	movl	%r12d, %eax
	vmovss	.LC1(%rip), %xmm1
	vaddss	(%rcx,%rbx,4), %xmm0, %xmm0
	andl	$1, %esi
	andl	$1, %eax
	andl	$1, %edx
	imulq	%r13, %rsi
	leaq	0(,%r11,4), %r9
	xorl	%ebp, %r12d
	imulq	%r13, %rax
	andl	$1, %r12d
	imulq	%r13, %rdx
	leaq	(%rsi,%r8), %r10
	imulq	%r11, %rsi
	leaq	(%rax,%r8), %rdi
	movq	-16(%rsp), %r8
	imulq	%r9, %r10
	imulq	%r9, %rdi
	imulq	%r11, %rax
	imulq	%rbx, %r12
	addq	%rdx, %r8
	imulq	%r11, %rdx
	vmulss	%xmm1, %xmm0, %xmm0
	imulq	%r9, %r8
	addq	%r14, %rax
	vmovss	%xmm0, (%rcx)
	vmovss	(%rcx,%r10), %xmm0
	vaddss	(%rcx,%r8), %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rdi)
	leaq	(%r11,%r14), %rdi
	addq	%rdi, %rsi
	movq	-32(%rsp), %rdi
	vmovss	(%rcx,%rsi,4), %xmm0
	addq	%rdi, %rdx
	vaddss	(%rcx,%rdx,4), %xmm0, %xmm0
	leaq	(%r14,%r15), %rdx
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	movq	%rdi, %rax
	addq	%r12, %rax
	addq	%r14, %r12
	addq	-24(%rsp), %r12
	addq	%r15, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	vmovss	(%rcx,%rax,4), %xmm0
	vaddss	(%rcx,%r12,4), %xmm0, %xmm0
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	vmulss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rcx,%rdx,4)
	ret
	.cfi_endproc
.LFE5503:
	.size	set_bnd.constprop.2, .-set_bnd.constprop.2
	.p2align 4
	.type	project, @function
project:
.LFB5497:
	.cfi_startproc
	leal	2(%rdi), %r10d
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %eax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r15d
	movq	%rdx, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%r10, %rbx
	movq	%r10, %rbp
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	shrq	%rbx
	movq	%rcx, %r12
	imulq	%rbx, %rbp
	movq	%rsi, 24(%rsp)
	movq	%r8, 16(%rsp)
	movl	%r10d, 40(%rsp)
	movq	%r10, 48(%rsp)
	movq	%rax, 80(%rsp)
	testl	%edi, %edi
	je	.L48
	vmovss	.LC3(%rip), %xmm2
	vxorps	%xmm3, %xmm3, %xmm3
	movl	$1, %r11d
	movl	%edi, (%rsp)
	movq	%rcx, 32(%rsp)
	movq	%rsi, %r12
	vcvtsi2ssq	%rax, %xmm3, %xmm1
	.p2align 4
	.p2align 3
.L51:
	movl	%r11d, %r8d
	leal	1(%r11), %r15d
	movl	$1, %esi
	movl	$1, %ecx
	leal	-1(%r8), %r14d
	movq	%r8, %r9
	movq	%r15, %r11
	shrq	%r8
	movl	%r14d, 8(%rsp)
	shrq	%r15
	shrq	%r14
	.p2align 4
	.p2align 3
.L52:
	movl	%r11d, %eax
	imulq	%rbx, %rcx
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%r15,%rcx), %rdi
	leaq	(%r14,%rcx), %rdx
	addq	%r8, %rcx
	addq	%rax, %rdi
	movl	8(%rsp), %eax
	vmovss	(%r12,%rdi,4), %xmm0
	xorl	%esi, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%rax, %rdx
	movl	%esi, %eax
	incl	%esi
	vsubss	(%r12,%rdx,4), %xmm0, %xmm0
	leal	-1(%rax), %edi
	movl	%esi, %edx
	xorl	%r9d, %eax
	andl	$1, %eax
	xorl	%r9d, %edx
	imulq	%rbp, %rax
	andl	$1, %edx
	imulq	%r10, %rdx
	addq	%rcx, %rax
	movl	%esi, %ecx
	addq	%rcx, %rdx
	salq	$2, %rax
	imulq	%rbx, %rdx
	addq	%r8, %rdx
	vaddss	0(%r13,%rdx,4), %xmm0, %xmm0
	movl	%edi, %edx
	xorl	%r9d, %edx
	andl	$1, %edx
	imulq	%r10, %rdx
	addq	%rdi, %rdx
	movq	16(%rsp), %rdi
	imulq	%rbx, %rdx
	addq	%r8, %rdx
	vsubss	0(%r13,%rdx,4), %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vdivss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rdi,%rax)
	movq	32(%rsp), %rdi
	movl	$0x00000000, (%rdi,%rax)
	cmpl	(%rsp), %esi
	jbe	.L52
	cmpl	(%rsp), %r11d
	jbe	.L51
	movl	(%rsp), %r15d
	movq	%rdi, %r12
.L48:
	movq	16(%rsp), %rsi
	movl	%r15d, %edi
	call	set_bnd.constprop.2
	movl	%r15d, %edi
	movq	%r12, %rsi
	call	set_bnd.constprop.2
	movl	40(%rsp), %eax
	movl	$20, %edi
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	movl	%edi, %ebx
	movl	%eax, %r14d
	shrl	%r14d
	imull	%eax, %r14d
	movq	16(%rsp), %rax
	movq	%r13, 16(%rsp)
	salq	$2, %r14
	leaq	(%rax,%r14), %rcx
	movq	%rax, %r13
	addq	%r12, %r14
	movq	%rcx, %rbp
	.p2align 4
	.p2align 3
.L53:
	vmovss	.LC5(%rip), %xmm1
	vmovss	.LC0(%rip), %xmm0
	movq	%r12, %rcx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movl	%r15d, %edi
	call	lin_solve_rb_step.constprop.1
	vmovss	.LC5(%rip), %xmm1
	movq	%r14, %rcx
	movq	%r12, %rdx
	vmovss	.LC0(%rip), %xmm0
	movq	%rbp, %rsi
	movl	%r15d, %edi
	call	lin_solve_rb_step.constprop.0
	movq	%r12, %rsi
	movl	%r15d, %edi
	call	set_bnd.constprop.2
	decl	%ebx
	jne	.L53
	movq	80(%rsp), %rcx
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r13
	movq	%rcx, %rax
	shrq	%rax
	movq	%rax, 56(%rsp)
	leal	1(%r15), %eax
	movq	%rax, %rdi
	movl	%eax, 68(%rsp)
	movq	%rax, 104(%rsp)
	shrq	%rdi
	imulq	%rbx, %rax
	movq	%rdi, 72(%rsp)
	movq	%rcx, %rdi
	imulq	%rbx, %rdi
	movq	%rax, 96(%rsp)
	movq	%rdi, 88(%rsp)
	testl	%r15d, %r15d
	je	.L54
	vmovss	.LC1(%rip), %xmm2
	vxorps	%xmm4, %xmm4, %xmm4
	movq	%r13, 32(%rsp)
	movl	$1, %r14d
	movq	48(%rsp), %r13
	vcvtsi2ssq	%rcx, %xmm4, %xmm1
	movl	%r15d, (%rsp)
	movq	$0, 40(%rsp)
	movl	%r14d, %r15d
	vmulss	%xmm2, %xmm1, %xmm1
	.p2align 4
	.p2align 3
.L57:
	movq	40(%rsp), %rax
	movl	%r15d, %r9d
	leal	1(%r15), %r14d
	xorl	%edi, %edi
	movq	%r9, %r10
	movq	%r14, %r15
	shrq	%r9
	shrq	%r14
	movl	$1, %ecx
	movl	$1, %edx
	movl	%eax, 16(%rsp)
	shrq	%rax
	movq	%rax, 8(%rsp)
	.p2align 4
	.p2align 3
.L58:
	movl	%ecx, %eax
	imulq	%rbx, %rdx
	xorl	%r10d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%r9,%rdx), %rsi
	leaq	(%r14,%rdx), %r8
	addq	8(%rsp), %rdx
	addq	%rsi, %rax
	movq	24(%rsp), %rsi
	salq	$2, %rax
	leaq	(%rsi,%rax), %r11
	movl	%r15d, %esi
	addq	32(%rsp), %rax
	xorl	%ecx, %esi
	andl	$1, %esi
	imulq	%rbp, %rsi
	addq	%rsi, %r8
	movl	16(%rsp), %esi
	vmovss	(%r12,%r8,4), %xmm0
	xorl	%ecx, %esi
	andl	$1, %esi
	imulq	%rbp, %rsi
	addq	%rsi, %rdx
	movl	%r10d, %esi
	vsubss	(%r12,%rdx,4), %xmm0, %xmm0
	leal	1(%rcx), %edx
	xorl	%edi, %esi
	movl	%edx, %r8d
	andl	$1, %esi
	movq	%rdx, %rcx
	xorl	%r10d, %r8d
	imulq	%r13, %rsi
	vfnmadd213ss	(%r11), %xmm1, %xmm0
	andl	$1, %r8d
	imulq	%r13, %r8
	addq	%rdi, %rsi
	incq	%rdi
	imulq	%rbx, %rsi
	addq	%rdx, %r8
	imulq	%rbx, %r8
	addq	%r9, %rsi
	addq	%r9, %r8
	vmovss	%xmm0, (%r11)
	vmovss	(%r12,%r8,4), %xmm0
	vsubss	(%r12,%rsi,4), %xmm0, %xmm0
	vfnmadd213ss	(%rax), %xmm1, %xmm0
	vmovss	%xmm0, (%rax)
	cmpl	(%rsp), %edx
	jbe	.L58
	incq	40(%rsp)
	cmpl	(%rsp), %r15d
	jbe	.L57
	movl	(%rsp), %r15d
	movq	24(%rsp), %rsi
	movq	32(%rsp), %r13
	movl	%r15d, %edi
	call	set_bnd.constprop.1
	movq	88(%rsp), %r12
	leal	-1(%r15), %r11d
	movq	%rbx, %r8
	movq	96(%rsp), %r14
	addq	$2, %r11
	movl	$1, %ecx
	vmovss	.LC2(%rip), %xmm1
	.p2align 4
	.p2align 3
.L60:
	movl	%ecx, %esi
	movq	%rcx, %rdi
	movl	%r15d, %edx
	notl	%esi
	xorl	%ecx, %edx
	andl	$1, %edi
	andl	$1, %esi
	imulq	48(%rsp), %rsi
	imulq	%rbp, %rdi
	andl	$1, %edx
	imulq	%rbp, %rdx
	leaq	(%rcx,%rsi), %rax
	imulq	%rbx, %rsi
	imulq	%rbx, %rax
	vmovss	0(%r13,%rax,4), %xmm0
	leaq	(%rdi,%r8), %rax
	vmovss	%xmm0, 0(%r13,%rax,4)
	leaq	(%rdx,%r8), %rax
	addq	56(%rsp), %rax
	vmovss	0(%r13,%rax,4), %xmm0
	movl	68(%rsp), %eax
	xorl	%ecx, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	leaq	(%rax,%r8), %r9
	addq	72(%rsp), %r9
	addq	%rbx, %r8
	vmovss	%xmm0, 0(%r13,%r9,4)
	movq	%rcx, %r9
	incq	%rcx
	shrq	%r9
	leaq	(%r9,%rbx), %r10
	addq	%r9, %rdx
	addq	%r9, %rdi
	addq	%r9, %rax
	addq	%rsi, %r10
	addq	%r12, %rdx
	addq	%r14, %rax
	vmovss	0(%r13,%r10,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, 0(%r13,%rdi,4)
	vmovss	0(%r13,%rdx,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, 0(%r13,%rax,4)
	cmpq	%r11, %rcx
	jne	.L60
.L61:
	movl	68(%rsp), %r14d
	leaq	(%rbx,%rbp), %rax
	movl	%r15d, %edx
	leaq	0(,%rbx,4), %r8
	movq	48(%rsp), %rdi
	vmovss	0(%r13,%rax,4), %xmm0
	andl	$1, %edx
	vaddss	0(%r13,%rbp,4), %xmm0, %xmm0
	movl	%r14d, %ecx
	movl	%r14d, %eax
	notl	%ecx
	imulq	%rdi, %rdx
	andl	$1, %eax
	andl	$1, %ecx
	imulq	%rdi, %rax
	imulq	%rdi, %rcx
	movq	104(%rsp), %rdi
	leaq	(%rax,%rdi), %rsi
	imulq	%rbx, %rax
	leaq	(%rcx,%rdi), %r9
	movq	80(%rsp), %rdi
	vmulss	%xmm2, %xmm0, %xmm0
	imulq	%r8, %r9
	imulq	%r8, %rsi
	imulq	%rbx, %rcx
	addq	%rdx, %rdi
	vmovss	%xmm0, 0(%r13)
	vmovss	0(%r13,%r9), %xmm0
	imulq	%rbx, %rdx
	imulq	%r8, %rdi
	vaddss	0(%r13,%rdi), %xmm0, %xmm0
	movq	72(%rsp), %rdi
	addq	%rdi, %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, 0(%r13,%rsi)
	leaq	(%rdi,%rbx), %rsi
	movq	56(%rsp), %rbx
	addq	%rsi, %rcx
	movq	96(%rsp), %rsi
	vmovss	0(%r13,%rcx,4), %xmm0
	movq	%rdi, %rcx
	addq	%rbx, %rdx
	vaddss	0(%r13,%rdx,4), %xmm0, %xmm0
	addq	%rsi, %rcx
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, 0(%r13,%rax,4)
	movl	%r14d, %eax
	xorl	%r15d, %eax
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%rax, %rbx
	addq	%rdi, %rax
	addq	88(%rsp), %rax
	movq	%rbx, %rdx
	addq	%rsi, %rdx
	vmovss	0(%r13,%rdx,4), %xmm0
	vaddss	0(%r13,%rax,4), %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, 0(%r13,%rcx,4)
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L54:
	.cfi_restore_state
	movq	24(%rsp), %rsi
	xorl	%edi, %edi
	call	set_bnd.constprop.1
	vmovss	.LC1(%rip), %xmm2
	jmp	.L61
	.cfi_endproc
.LFE5497:
	.size	project, .-project
	.p2align 4
	.type	advect, @function
advect:
.LFB5496:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%edi, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	vxorps	%xmm3, %xmm3, %xmm3
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	vcvtsi2ssq	%rax, %xmm3, %xmm6
	vmulss	%xmm0, %xmm6, %xmm4
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rcx, %rbx
	leal	1(%rax), %ecx
	movl	%esi, -48(%rsp)
	leal	2(%rax), %esi
	movl	%edi, -100(%rsp)
	movq	%rcx, %rdi
	movq	%rsi, %r15
	movq	%rsi, -96(%rsp)
	movq	%rax, -24(%rsp)
	shrq	%rdi
	shrq	%r15
	movl	%ecx, -44(%rsp)
	movq	%rcx, -8(%rsp)
	imulq	%r15, %rsi
	movq	%rdx, -80(%rsp)
	movq	%r8, -72(%rsp)
	imulq	%r15, %rcx
	movq	%r9, -64(%rsp)
	movq	%rdi, -40(%rsp)
	movl	$1, -112(%rsp)
	movq	%rsi, %r11
	movq	%rax, %rsi
	vmovss	.LC1(%rip), %xmm2
	shrq	%rsi
	vmovss	.LC0(%rip), %xmm7
	movq	%rcx, -32(%rsp)
	movq	%rsi, -56(%rsp)
	movl	%eax, %esi
	imulq	%r15, %rax
	movq	%rax, -16(%rsp)
	testl	%esi, %esi
	je	.L91
	.p2align 4
	.p2align 3
.L76:
	movl	-112(%rsp), %eax
	movl	$1, %r9d
	movq	%rax, %rcx
	vcvtsi2ssq	%rax, %xmm3, %xmm5
	shrq	%rcx
	movq	%rcx, -88(%rsp)
	jmp	.L83
	.p2align 4
	.p2align 3
.L105:
	vaddss	%xmm2, %xmm6, %xmm9
	vcomiss	%xmm9, %xmm0
	ja	.L80
	vcvttss2sil	%xmm0, %edx
	vcvtsi2ssl	%edx, %xmm3, %xmm9
	vsubss	%xmm9, %xmm0, %xmm9
	leal	1(%rdx), %ecx
.L102:
	movslq	%ecx, %rbp
	movslq	%edx, %rdi
	vsubss	%xmm9, %xmm7, %xmm8
	shrq	%rbp
	shrq	%rdi
	vcomiss	%xmm1, %xmm2
	ja	.L94
.L106:
	vaddss	%xmm2, %xmm6, %xmm0
	vcomiss	%xmm0, %xmm1
	ja	.L82
	vcvttss2sil	%xmm1, %eax
	movslq	%eax, %r10
	vcvtsi2ssl	%eax, %xmm3, %xmm0
	vsubss	%xmm0, %xmm1, %xmm1
	imulq	%r15, %r10
	movl	%edx, %esi
	xorl	%eax, %esi
	leaq	(%rdi,%r10), %r14
.L103:
	vsubss	%xmm1, %xmm7, %xmm0
	leal	1(%rax), %r12d
	leaq	(%r10,%r15), %r8
	xorl	%ecx, %eax
	addq	%rbp, %r10
.L81:
	xorl	%r12d, %edx
	xorl	%r12d, %ecx
	addq	%r8, %rdi
	andl	$1, %esi
	andl	$1, %edx
	andl	$1, %ecx
	andl	$1, %eax
	addq	%rbp, %r8
	imulq	%r11, %rdx
	incl	%r9d
	imulq	%r11, %rcx
	imulq	%r11, %rsi
	imulq	%r11, %rax
	addq	%rdx, %rdi
	addq	%rcx, %r8
	vmulss	(%rbx,%rdi,4), %xmm1, %xmm10
	vmulss	(%rbx,%r8,4), %xmm1, %xmm1
	addq	%r14, %rsi
	addq	%r10, %rax
	vfmadd231ss	(%rbx,%rsi,4), %xmm0, %xmm10
	vfmadd132ss	(%rbx,%rax,4), %xmm1, %xmm0
	movq	-80(%rsp), %rax
	vmulss	%xmm9, %xmm0, %xmm0
	vfmadd132ss	%xmm8, %xmm0, %xmm10
	vmovss	%xmm10, (%rax,%r13)
	cmpl	%r9d, -100(%rsp)
	jb	.L104
.L83:
	movl	-112(%rsp), %eax
	movl	%r9d, %edx
	vmovaps	%xmm4, %xmm0
	movq	-72(%rsp), %rsi
	movq	-64(%rsp), %rdi
	vcvtsi2ssq	%rdx, %xmm3, %xmm1
	xorl	%r9d, %eax
	andl	$1, %eax
	imulq	-96(%rsp), %rax
	addq	%rdx, %rax
	imulq	%r15, %rax
	addq	-88(%rsp), %rax
	vfnmadd132ss	(%rsi,%rax,4), %xmm5, %xmm0
	vfnmadd231ss	(%rdi,%rax,4), %xmm4, %xmm1
	leaq	0(,%rax,4), %r13
	vcomiss	%xmm0, %xmm2
	jbe	.L105
	xorl	%edi, %edi
	xorl	%ebp, %ebp
	xorl	%edx, %edx
	vcomiss	%xmm1, %xmm2
	vmovaps	%xmm2, %xmm8
	vmovaps	%xmm2, %xmm9
	movl	$1, %ecx
	jbe	.L106
.L94:
	movq	%rbp, %r10
	movl	%ecx, %eax
	movq	%r15, %r8
	movq	%rdi, %r14
	movl	%edx, %esi
	movl	$1, %r12d
	vmovaps	%xmm2, %xmm0
	vmovaps	%xmm2, %xmm1
	jmp	.L81
	.p2align 4
	.p2align 3
.L80:
	vcvttss2sil	%xmm9, %edx
	vcvtsi2ssl	%edx, %xmm3, %xmm0
	leal	1(%rdx), %ecx
	vsubss	%xmm0, %xmm9, %xmm9
	jmp	.L102
	.p2align 4
	.p2align 3
.L82:
	vcvttss2sil	%xmm0, %eax
	movslq	%eax, %r10
	movl	%edx, %esi
	vcvtsi2ssl	%eax, %xmm3, %xmm1
	imulq	%r15, %r10
	vsubss	%xmm1, %xmm0, %xmm1
	xorl	%eax, %esi
	leaq	(%rdi,%r10), %r14
	jmp	.L103
	.p2align 4
	.p2align 3
.L104:
	incl	-112(%rsp)
	movl	-112(%rsp), %eax
	cmpl	%eax, -100(%rsp)
	jnb	.L76
	movl	-100(%rsp), %eax
	vmovss	.LC2(%rip), %xmm1
	movq	%r15, %r14
	movl	$1, %edx
	movq	-80(%rsp), %rsi
	vmovaps	%xmm1, %xmm3
	movq	%r11, %rbp
	decl	%eax
	addq	$2, %rax
	movq	%rax, -88(%rsp)
	jmp	.L90
	.p2align 4
	.p2align 3
.L87:
	vmovss	%xmm0, (%r9)
	vmovss	0(%r13), %xmm0
	cmpl	$2, -48(%rsp)
	vmovss	%xmm0, (%r12)
	jne	.L88
	imulq	%r15, %r11
	addq	-112(%rsp), %r11
	addq	%rcx, %r10
	addq	-16(%rsp), %r10
	vmovss	(%rsi,%r11,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx)
	vmovss	(%rsi,%r10,4), %xmm0
	vxorps	%xmm1, %xmm0, %xmm0
.L89:
	addq	%r8, %rcx
	addq	-32(%rsp), %rcx
	incq	%rdx
	addq	%r15, %r14
	vmovss	%xmm0, (%rsi,%rcx,4)
	cmpq	-88(%rsp), %rdx
	je	.L107
.L90:
	movq	-96(%rsp), %r11
	movl	%edx, %edi
	movq	%rdx, %r9
	notl	%edi
	movq	-56(%rsp), %rbx
	movl	-44(%rsp), %r8d
	andl	$1, %r9d
	andl	$1, %edi
	imulq	%rbp, %r9
	imulq	%rdi, %r11
	leaq	(%r14,%rbx), %rcx
	xorl	%edx, %r8d
	movq	-40(%rsp), %rbx
	andl	$1, %r8d
	leaq	(%rdx,%r11), %rax
	imulq	%rbp, %r8
	imulq	%r15, %rax
	vmovss	(%rsi,%rax,4), %xmm0
	movl	-100(%rsp), %eax
	xorl	%edx, %eax
	andl	$1, %eax
	movq	%rax, %r10
	imulq	%rbp, %r10
	addq	%r10, %rcx
	leaq	(%rsi,%rcx,4), %r13
	leaq	(%r14,%rbx), %rcx
	addq	%r8, %rcx
	leaq	(%rsi,%rcx,4), %r12
	movq	%rdx, %rcx
	shrq	%rcx
	leaq	(%rcx,%r15), %rbx
	movq	%rbx, -112(%rsp)
	leaq	(%r9,%rcx), %rbx
	addq	%r14, %r9
	cmpl	$1, -48(%rsp)
	leaq	(%rsi,%rbx,4), %rbx
	leaq	(%rsi,%r9,4), %r9
	jne	.L87
	vxorps	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%r9)
	vmovss	0(%r13), %xmm0
	vxorps	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%r12)
.L88:
	imulq	%rbp, %rdi
	addq	-112(%rsp), %rdi
	imulq	-96(%rsp), %rax
	addq	-24(%rsp), %rax
	vmovss	(%rsi,%rdi,4), %xmm0
	imulq	%r15, %rax
	addq	%rcx, %rax
	vmovss	%xmm0, (%rbx)
	vmovss	(%rsi,%rax,4), %xmm0
	jmp	.L89
	.p2align 4
	.p2align 3
.L107:
	movq	%rbp, %r11
.L91:
	movq	-80(%rsp), %rbx
	movl	-44(%rsp), %r14d
	leaq	(%r15,%r11), %rax
	leaq	0(,%r15,4), %rdi
	movq	-96(%rsp), %rsi
	movl	-100(%rsp), %r10d
	movq	-8(%rsp), %r9
	vmovss	(%rbx,%rax,4), %xmm0
	movl	%r14d, %ecx
	movl	%r14d, %eax
	vaddss	(%rbx,%r11,4), %xmm0, %xmm0
	notl	%ecx
	andl	$1, %eax
	movl	%r10d, %edx
	andl	$1, %ecx
	imulq	%rsi, %rax
	andl	$1, %edx
	imulq	%rsi, %rcx
	imulq	%rsi, %rdx
	leaq	(%rax,%r9), %rsi
	imulq	%r15, %rax
	leaq	(%rcx,%r9), %r8
	movq	-24(%rsp), %r9
	imulq	%rdi, %rsi
	imulq	%rdi, %r8
	imulq	%r15, %rcx
	addq	%rdx, %r9
	imulq	%r15, %rdx
	vmulss	%xmm2, %xmm0, %xmm0
	imulq	%rdi, %r9
	movq	-40(%rsp), %rdi
	vmovss	%xmm0, (%rbx)
	vmovss	(%rbx,%r8), %xmm0
	vaddss	(%rbx,%r9), %xmm0, %xmm0
	addq	%rdi, %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rsi)
	leaq	(%r15,%rdi), %rsi
	addq	%rsi, %rcx
	movq	-56(%rsp), %rsi
	vmovss	(%rbx,%rcx,4), %xmm0
	movq	%rdi, %rcx
	addq	%rsi, %rdx
	vaddss	(%rbx,%rdx,4), %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
	movl	%r10d, %eax
	xorl	%r14d, %eax
	movq	-32(%rsp), %r14
	andl	$1, %eax
	imulq	%r11, %rax
	addq	%r14, %rcx
	addq	%rax, %rsi
	addq	%rdi, %rax
	addq	-16(%rsp), %rax
	movq	%rsi, %rdx
	addq	%r14, %rdx
	vmovss	(%rbx,%rdx,4), %xmm0
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5496:
	.size	advect, .-advect
	.p2align 4
	.globl	dens_step
	.type	dens_step, @function
dens_step:
.LFB5498:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdx, %r12
	leal	2(%rdi), %edx
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%edi, %r13d
	subq	$184, %rsp
	.cfi_def_cfa_offset 240
	movq	%rcx, 160(%rsp)
	movl	%edx, %ecx
	movq	%rsi, 40(%rsp)
	imull	%edx, %ecx
	movq	%r8, 168(%rsp)
	vmovss	%xmm1, 156(%rsp)
	testl	%ecx, %ecx
	je	.L117
	movq	%rsi, %rdi
	leaq	4(%r12), %rsi
	movq	%rdi, %rax
	subq	%rsi, %rax
	cmpq	$8, %rax
	jbe	.L113
	cmpl	$1, %ecx
	je	.L113
	leal	-1(%rcx), %eax
	cmpl	$2, %eax
	jbe	.L126
	vbroadcastss	156(%rsp), %xmm2
	movl	%ecx, %esi
	xorl	%eax, %eax
	shrl	$2, %esi
	salq	$4, %rsi
	.p2align 4
	.p2align 3
.L115:
	vmovups	(%r12,%rax), %xmm1
	vfmadd213ps	(%rdi,%rax), %xmm2, %xmm1
	vmovups	%xmm1, (%rdi,%rax)
	addq	$16, %rax
	cmpq	%rax, %rsi
	jne	.L115
	movl	%ecx, %eax
	andl	$-4, %eax
	testb	$3, %cl
	je	.L117
	subl	%eax, %ecx
	cmpl	$1, %ecx
	je	.L119
.L114:
	vmovss	156(%rsp), %xmm7
	movq	40(%rsp), %rbx
	movl	%eax, %esi
	salq	$2, %rsi
	vmovq	(%r12,%rsi), %xmm3
	leaq	(%rbx,%rsi), %rdi
	movl	%ecx, %esi
	vmovq	(%rdi), %xmm2
	andl	$-2, %esi
	addl	%esi, %eax
	vmovsldup	%xmm7, %xmm1
	vfmadd132ps	%xmm3, %xmm2, %xmm1
	vmovlps	%xmm1, (%rdi)
	cmpl	%ecx, %esi
	je	.L117
.L119:
	movq	40(%rsp), %rbx
	salq	$2, %rax
	vmovss	156(%rsp), %xmm1
	leaq	(%rbx,%rax), %rcx
	vmovss	(%rcx), %xmm4
	vfmadd132ss	(%r12,%rax), %xmm4, %xmm1
	vmovss	%xmm1, (%rcx)
.L117:
	movl	%edx, %ecx
	movq	40(%rsp), %rbx
	movl	%edx, %edi
	movl	%r13d, %eax
	shrl	%ecx
	movq	%rdi, %rbp
	vxorps	%xmm1, %xmm1, %xmm1
	movq	%rax, %r8
	imull	%edx, %ecx
	vcvtsi2ssq	%rax, %xmm1, %xmm1
	vmulss	156(%rsp), %xmm0, %xmm0
	shrq	%r8
	movq	%rdi, (%rsp)
	movl	$20, 152(%rsp)
	salq	$2, %rcx
	addq	%rcx, %rbx
	movq	%rbx, 48(%rsp)
	leaq	(%r12,%rcx), %rbx
	leal	1(%r13), %ecx
	movq	%rbx, 24(%rsp)
	movq	%rdi, %rbx
	movq	%rcx, %r11
	movq	%rcx, %r14
	shrq	%rbx
	movl	%ecx, 16(%rsp)
	shrq	%r14
	imulq	%rbx, %rbp
	leaq	0(,%rbx,4), %r10
	movq	%rbx, %r9
	movq	%rbx, %r15
	imulq	%rax, %r9
	movq	%r10, 8(%rsp)
	imulq	%rcx, %r15
	vmulss	%xmm1, %xmm0, %xmm0
	leaq	(%r12,%rbp,4), %rsi
	leaq	(%rbx,%rbp), %rdx
	movq	%rsi, 56(%rsp)
	leaq	(%r12,%rdx,4), %rsi
	movl	%ecx, %edx
	notl	%edx
	movq	%rsi, 64(%rsp)
	vmulss	%xmm1, %xmm0, %xmm5
	vmovss	.LC5(%rip), %xmm1
	andl	$1, %edx
	vfmadd213ss	.LC0(%rip), %xmm5, %xmm1
	movq	%r15, 144(%rsp)
	movq	%rdx, %rsi
	imulq	%rdi, %rsi
	vmovss	%xmm5, 20(%rsp)
	leaq	(%rcx,%rsi), %rdx
	imulq	%rbx, %rsi
	imulq	%r10, %rdx
	addq	%r12, %rdx
	movq	%rdx, 72(%rsp)
	movl	%r13d, %edx
	andl	$1, %edx
	imulq	%rdi, %rdx
	addq	%rdx, %rax
	imulq	%rbx, %rdx
	imulq	%r10, %rax
	addq	%r8, %rdx
	addq	%r12, %rax
	movq	%rax, 80(%rsp)
	movl	%ecx, %eax
	andl	$1, %eax
	imulq	%rdi, %rax
	addq	%rax, %rcx
	imulq	%rbx, %rax
	imulq	%r10, %rcx
	addq	%r14, %rax
	leaq	(%r12,%rax,4), %rax
	leaq	(%r12,%rcx), %rdi
	leaq	(%rbx,%r14), %rcx
	movq	%rax, 112(%rsp)
	movl	%r11d, %eax
	movq	%rdi, 88(%rsp)
	leaq	(%r12,%rdx,4), %rdi
	xorl	%r13d, %eax
	movq	%rsi, %rdx
	movq	%rdi, 96(%rsp)
	andl	$1, %eax
	addq	%rcx, %rdx
	imulq	%rbp, %rax
	leaq	(%r12,%rdx,4), %rdi
	leaq	(%r8,%r15), %rdx
	movq	%rdi, 104(%rsp)
	addq	%rax, %rdx
	leaq	(%r12,%rdx,4), %rdi
	leaq	(%r14,%r9), %rdx
	addq	%rdx, %rax
	movq	%rdi, 120(%rsp)
	movl	%r13d, %edi
	movq	%r9, %r13
	leaq	(%r12,%rax,4), %rax
	movq	%rax, 128(%rsp)
	leaq	(%r14,%r15), %rax
	movq	%r14, %r15
	movq	%r8, %r14
	leaq	(%r12,%rax,4), %rax
	movq	%rax, 136(%rsp)
	.p2align 4
	.p2align 3
.L112:
	vmovss	20(%rsp), %xmm0
	movq	%r12, %rcx
	vmovss	%xmm1, 36(%rsp)
	movl	%edi, 32(%rsp)
	movq	24(%rsp), %rdx
	movq	40(%rsp), %rsi
	call	lin_solve_rb_step.constprop.1
	vmovss	36(%rsp), %xmm1
	movq	%r12, %rdx
	vmovss	20(%rsp), %xmm0
	movq	48(%rsp), %rsi
	movl	32(%rsp), %edi
	movq	24(%rsp), %rcx
	call	lin_solve_rb_step.constprop.0
	movl	32(%rsp), %edi
	movl	$1, %esi
	vmovss	36(%rsp), %xmm1
	vmovss	.LC1(%rip), %xmm2
	movq	144(%rsp), %r8
	testl	%edi, %edi
	je	.L125
	.p2align 4
	.p2align 3
.L123:
	movl	%esi, %r9d
	movl	%esi, %ecx
	movl	%esi, %r11d
	movl	%edi, %edx
	notl	%r9d
	movq	%rcx, %r10
	xorl	%esi, %edx
	andl	$1, %r11d
	andl	$1, %r9d
	imulq	(%rsp), %r9
	imulq	%rbx, %r10
	andl	$1, %edx
	imulq	%rbp, %r11
	imulq	%rbp, %rdx
	leaq	(%rcx,%r9), %rax
	imulq	8(%rsp), %rax
	imulq	%rbx, %r9
	shrq	%rcx
	vmovss	(%r12,%rax), %xmm0
	leaq	(%r10,%r11), %rax
	addq	%rcx, %r11
	vmovss	%xmm0, (%r12,%rax,4)
	leaq	(%r10,%rdx), %rax
	addq	%rcx, %rdx
	addq	%r14, %rax
	addq	%r13, %rdx
	vmovss	(%r12,%rax,4), %xmm0
	movl	16(%rsp), %eax
	xorl	%esi, %eax
	incl	%esi
	andl	$1, %eax
	imulq	%rbp, %rax
	addq	%rax, %r10
	addq	%rcx, %rax
	addq	%r15, %r10
	addq	%r8, %rax
	vmovss	%xmm0, (%r12,%r10,4)
	leaq	(%rbx,%rcx), %r10
	addq	%r9, %r10
	vmovss	(%r12,%r10,4), %xmm0
	vmovss	%xmm0, (%r12,%r11,4)
	vmovss	(%r12,%rdx,4), %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	cmpl	%esi, %edi
	jnb	.L123
.L125:
	movq	56(%rsp), %rax
	decl	152(%rsp)
	vmovss	(%rax), %xmm0
	movq	64(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	72(%rsp), %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%r12)
	vmovss	(%rax), %xmm0
	movq	80(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	88(%rsp), %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	movq	96(%rsp), %rax
	vmovss	(%rax), %xmm0
	movq	104(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	112(%rsp), %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	movq	120(%rsp), %rax
	vmovss	(%rax), %xmm0
	movq	128(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	136(%rsp), %rax
	vmulss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	jne	.L112
	vmovss	156(%rsp), %xmm0
	movq	168(%rsp), %r9
	movq	%r12, %rcx
	xorl	%esi, %esi
	movq	160(%rsp), %r8
	movq	40(%rsp), %rdx
	addq	$184, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	advect
.L113:
	.cfi_restore_state
	vmovss	156(%rsp), %xmm2
	movq	40(%rsp), %rsi
	xorl	%eax, %eax
.L121:
	vmovss	(%r12,%rax,4), %xmm1
	vfmadd213ss	(%rsi,%rax,4), %xmm2, %xmm1
	vmovss	%xmm1, (%rsi,%rax,4)
	incq	%rax
	cmpq	%rax, %rcx
	jne	.L121
	jmp	.L117
.L126:
	xorl	%eax, %eax
	jmp	.L114
	.cfi_endproc
.LFE5498:
	.size	dens_step, .-dens_step
	.p2align 4
	.globl	vel_step
	.type	vel_step, @function
vel_step:
.LFB5499:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leal	2(%rdi), %r15d
	vmovaps	%xmm0, %xmm2
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r13d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%r8, %rbx
	subq	$200, %rsp
	.cfi_def_cfa_offset 256
	movq	%rdx, 56(%rsp)
	movl	%r15d, %edx
	movq	%rsi, 176(%rsp)
	imull	%r15d, %edx
	movq	%rcx, 184(%rsp)
	vmovss	%xmm1, 172(%rsp)
	testl	%edx, %edx
	je	.L162
	movq	%rsi, %rdi
	cmpl	$1, %edx
	movq	%rcx, %r8
	leaq	4(%rcx), %rcx
	movq	%rdi, %rax
	setne	%sil
	subq	%rcx, %rax
	cmpq	$8, %rax
	jbe	.L150
	testb	%sil, %sil
	je	.L150
	leal	-1(%rdx), %eax
	cmpl	$2, %eax
	jbe	.L172
	vbroadcastss	172(%rsp), %xmm1
	movl	%edx, %ecx
	xorl	%eax, %eax
	shrl	$2, %ecx
	salq	$4, %rcx
	.p2align 4
	.p2align 3
.L152:
	vmovups	(%r8,%rax), %xmm0
	vfmadd213ps	(%rdi,%rax), %xmm1, %xmm0
	vmovups	%xmm0, (%rdi,%rax)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jne	.L152
	movl	%edx, %eax
	andl	$-4, %eax
	testb	$3, %dl
	je	.L157
	movl	%edx, %edi
	subl	%eax, %edi
	cmpl	$1, %edi
	je	.L154
.L151:
	vmovss	172(%rsp), %xmm7
	movq	176(%rsp), %r8
	movl	%eax, %ecx
	movq	184(%rsp), %r14
	salq	$2, %rcx
	addq	%rcx, %r8
	vmovq	(%r14,%rcx), %xmm0
	vmovq	(%r8), %xmm3
	movl	%edi, %ecx
	andl	$-2, %ecx
	addl	%ecx, %eax
	vmovsldup	%xmm7, %xmm1
	vfmadd132ps	%xmm1, %xmm3, %xmm0
	vmovlps	%xmm0, (%r8)
	cmpl	%ecx, %edi
	je	.L157
.L154:
	movq	176(%rsp), %rdi
	salq	$2, %rax
	vmovss	172(%rsp), %xmm0
	leaq	(%rdi,%rax), %rcx
	movq	184(%rsp), %rdi
	vmovss	(%rcx), %xmm4
	vfmadd132ss	(%rdi,%rax), %xmm4, %xmm0
	vmovss	%xmm0, (%rcx)
.L157:
	movq	56(%rsp), %rdi
	leaq	4(%rbx), %rcx
	movq	%rdi, %rax
	subq	%rcx, %rax
	cmpq	$8, %rax
	jbe	.L158
	testb	%sil, %sil
	je	.L158
	leal	-1(%rdx), %eax
	cmpl	$2, %eax
	jbe	.L173
	vbroadcastss	172(%rsp), %xmm1
	movl	%edx, %ecx
	xorl	%eax, %eax
	movq	%rdi, %rsi
	shrl	$2, %ecx
	salq	$4, %rcx
	.p2align 4
	.p2align 3
.L160:
	vmovups	(%rbx,%rax), %xmm0
	vfmadd213ps	(%rsi,%rax), %xmm1, %xmm0
	vmovups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%rax, %rcx
	jne	.L160
	movl	%edx, %eax
	andl	$-4, %eax
	testb	$3, %dl
	je	.L162
	subl	%eax, %edx
	cmpl	$1, %edx
	je	.L164
.L159:
	vmovss	172(%rsp), %xmm7
	movq	56(%rsp), %rdi
	movl	%eax, %ecx
	salq	$2, %rcx
	vmovq	(%rbx,%rcx), %xmm3
	leaq	(%rdi,%rcx), %rsi
	movl	%edx, %ecx
	vmovq	(%rsi), %xmm1
	andl	$-2, %ecx
	addl	%ecx, %eax
	vmovsldup	%xmm7, %xmm0
	vfmadd132ps	%xmm3, %xmm1, %xmm0
	vmovlps	%xmm0, (%rsi)
	cmpl	%ecx, %edx
	je	.L162
.L164:
	movq	56(%rsp), %rdi
	salq	$2, %rax
	vmovss	172(%rsp), %xmm0
	leaq	(%rdi,%rax), %rdx
	vmovss	(%rdx), %xmm5
	vfmadd132ss	(%rbx,%rax), %xmm5, %xmm0
	vmovss	%xmm0, (%rdx)
.L162:
	vmulss	172(%rsp), %xmm2, %xmm2
	movl	%r13d, %eax
	vxorps	%xmm0, %xmm0, %xmm0
	movl	%r15d, 32(%rsp)
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	vmovss	.LC5(%rip), %xmm1
	movq	%rax, 24(%rsp)
	movl	%r15d, %eax
	movq	176(%rsp), %rdi
	shrl	%eax
	movq	%rbx, 40(%rsp)
	movl	$20, %ebp
	movq	184(%rsp), %rsi
	imull	%r15d, %eax
	movq	%rdi, %r14
	salq	$2, %rax
	movq	%rdi, %r15
	movq	%rsi, %r12
	movq	%rax, 16(%rsp)
	addq	%rax, %r14
	movq	%rsi, %rbx
	addq	%rax, %r12
	vmulss	%xmm0, %xmm2, %xmm2
	vmulss	%xmm0, %xmm2, %xmm6
	vfmadd213ss	.LC0(%rip), %xmm6, %xmm1
	vmovss	%xmm6, 48(%rsp)
	.p2align 4
	.p2align 3
.L149:
	vmovss	48(%rsp), %xmm0
	movq	%rbx, %rcx
	movq	%r12, %rdx
	movq	%r15, %rsi
	movl	%r13d, %edi
	vmovss	%xmm1, 8(%rsp)
	call	lin_solve_rb_step.constprop.1
	vmovss	8(%rsp), %xmm1
	movq	%r12, %rcx
	movq	%rbx, %rdx
	vmovss	48(%rsp), %xmm0
	movq	%r14, %rsi
	movl	%r13d, %edi
	call	lin_solve_rb_step.constprop.0
	movq	%rbx, %rsi
	movl	%r13d, %edi
	call	set_bnd.constprop.1
	decl	%ebp
	vmovss	8(%rsp), %xmm1
	jne	.L149
	movq	16(%rsp), %rax
	movq	56(%rsp), %rdi
	leal	1(%r13), %ecx
	movl	$20, 168(%rsp)
	movl	32(%rsp), %r15d
	movq	%rcx, %r11
	movq	%rcx, %r14
	movq	40(%rsp), %rbx
	movq	24(%rsp), %r10
	movl	%ecx, 24(%rsp)
	shrq	%r14
	addq	%rax, %rdi
	movq	%rdi, 64(%rsp)
	movl	%r15d, %edi
	movq	%rdi, %rbp
	movq	%rdi, %r12
	addq	%rbx, %rax
	movq	%r10, %r8
	shrq	%rbp
	movq	%rax, 32(%rsp)
	movq	%r10, %r9
	shrq	%r8
	imulq	%rbp, %r12
	movq	%rbp, %r15
	movq	%rdi, 16(%rsp)
	imulq	%rcx, %r15
	imulq	%rbp, %r9
	leaq	(%rbx,%r12,4), %rax
	movq	%rax, 72(%rsp)
	leaq	0(%rbp,%r12), %rax
	movq	%r15, 160(%rsp)
	leaq	(%rbx,%rax,4), %rax
	movq	%rax, 80(%rsp)
	movl	%ecx, %eax
	notl	%eax
	andl	$1, %eax
	imulq	%rdi, %rax
	movq	%rax, %rsi
	leaq	0(,%rbp,4), %rax
	movq	%rax, %rdx
	leaq	(%rcx,%rsi), %rax
	imulq	%rdx, %rax
	movq	%rdx, 8(%rsp)
	imulq	%rbp, %rsi
	addq	%rbx, %rax
	movq	%rax, 88(%rsp)
	movl	%r13d, %eax
	andl	$1, %eax
	movq	%rax, %rdx
	movq	%r10, %rax
	movq	8(%rsp), %r10
	imulq	%rdi, %rdx
	addq	%rdx, %rax
	imulq	%rbp, %rdx
	imulq	%r10, %rax
	addq	%r8, %rdx
	addq	%rbx, %rax
	movq	%rax, 96(%rsp)
	movl	%ecx, %eax
	andl	$1, %eax
	imulq	%rdi, %rax
	addq	%rax, %rcx
	imulq	%rbp, %rax
	imulq	%r10, %rcx
	addq	%r14, %rax
	leaq	(%rbx,%rax,4), %rax
	leaq	(%rbx,%rcx), %rdi
	leaq	0(%rbp,%r14), %rcx
	movq	%rax, 128(%rsp)
	movl	%r11d, %eax
	movq	%rdi, 104(%rsp)
	leaq	(%rbx,%rdx,4), %rdi
	xorl	%r13d, %eax
	movq	%rsi, %rdx
	movq	%rdi, 112(%rsp)
	andl	$1, %eax
	addq	%rcx, %rdx
	imulq	%r12, %rax
	leaq	(%rbx,%rdx,4), %rdi
	leaq	(%r8,%r15), %rdx
	movq	%rdi, 120(%rsp)
	addq	%rax, %rdx
	leaq	(%rbx,%rdx,4), %rdi
	leaq	(%r14,%r9), %rdx
	addq	%rdx, %rax
	movq	%rdi, 136(%rsp)
	movl	%r13d, %edi
	movq	%r9, %r13
	leaq	(%rbx,%rax,4), %rax
	movq	%rax, 144(%rsp)
	leaq	(%r14,%r15), %rax
	movq	%r14, %r15
	movq	%r8, %r14
	leaq	(%rbx,%rax,4), %rax
	movq	%rax, 152(%rsp)
	.p2align 4
	.p2align 3
.L169:
	vmovss	48(%rsp), %xmm0
	movq	%rbx, %rcx
	vmovss	%xmm1, 52(%rsp)
	movl	%edi, 40(%rsp)
	movq	32(%rsp), %rdx
	movq	56(%rsp), %rsi
	call	lin_solve_rb_step.constprop.1
	vmovss	52(%rsp), %xmm1
	movq	%rbx, %rdx
	vmovss	48(%rsp), %xmm0
	movq	64(%rsp), %rsi
	movl	40(%rsp), %edi
	movq	32(%rsp), %rcx
	call	lin_solve_rb_step.constprop.0
	movl	40(%rsp), %edi
	movl	$1, %esi
	vmovss	.LC2(%rip), %xmm2
	vmovss	52(%rsp), %xmm1
	vmovss	.LC1(%rip), %xmm3
	movq	160(%rsp), %r8
	testl	%edi, %edi
	je	.L171
	.p2align 4
	.p2align 3
.L168:
	movl	%esi, %r9d
	movl	%esi, %ecx
	movl	%esi, %r11d
	movl	%edi, %edx
	notl	%r9d
	movq	%rcx, %r10
	xorl	%esi, %edx
	andl	$1, %r11d
	andl	$1, %r9d
	imulq	16(%rsp), %r9
	imulq	%rbp, %r10
	andl	$1, %edx
	imulq	%r12, %r11
	imulq	%r12, %rdx
	leaq	(%rcx,%r9), %rax
	imulq	8(%rsp), %rax
	imulq	%rbp, %r9
	shrq	%rcx
	vmovss	(%rbx,%rax), %xmm0
	leaq	(%r10,%r11), %rax
	addq	%rcx, %r11
	vmovss	%xmm0, (%rbx,%rax,4)
	leaq	(%r10,%rdx), %rax
	addq	%rcx, %rdx
	addq	%r14, %rax
	addq	%r13, %rdx
	vmovss	(%rbx,%rax,4), %xmm0
	movl	24(%rsp), %eax
	xorl	%esi, %eax
	incl	%esi
	andl	$1, %eax
	imulq	%r12, %rax
	addq	%rax, %r10
	addq	%rcx, %rax
	addq	%r15, %r10
	addq	%r8, %rax
	vmovss	%xmm0, (%rbx,%r10,4)
	leaq	0(%rbp,%rcx), %r10
	addq	%r9, %r10
	vmovss	(%rbx,%r10,4), %xmm0
	vxorps	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%r11,4)
	vmovss	(%rbx,%rdx,4), %xmm0
	vxorps	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
	cmpl	%esi, %edi
	jnb	.L168
.L171:
	movq	72(%rsp), %rax
	decl	168(%rsp)
	vmovss	(%rax), %xmm0
	movq	80(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	88(%rsp), %rax
	vmulss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx)
	vmovss	(%rax), %xmm0
	movq	96(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	104(%rsp), %rax
	vmulss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	movq	112(%rsp), %rax
	vmovss	(%rax), %xmm0
	movq	120(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	128(%rsp), %rax
	vmulss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	movq	136(%rsp), %rax
	vmovss	(%rax), %xmm0
	movq	144(%rsp), %rax
	vaddss	(%rax), %xmm0, %xmm0
	movq	152(%rsp), %rax
	vmulss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	jne	.L169
	movq	184(%rsp), %r14
	movq	56(%rsp), %r15
	movq	%rbx, %rdx
	movl	%edi, %r13d
	movq	176(%rsp), %rbp
	movq	%r15, %r8
	movq	%r14, %rsi
	movq	%rbp, %rcx
	call	project
	vmovss	172(%rsp), %xmm0
	movq	%rbx, %r9
	movq	%r14, %r8
	movq	%r14, %rcx
	movq	%rbp, %rdx
	movl	%r13d, %edi
	movl	$1, %esi
	call	advect
	vmovss	172(%rsp), %xmm0
	movq	%r14, %r8
	movq	%rbx, %rcx
	movq	%r15, %rdx
	movl	%r13d, %edi
	movq	%rbx, %r9
	movl	$2, %esi
	call	advect
	addq	$200, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %r8
	movq	%r14, %rcx
	popq	%rbx
	.cfi_def_cfa_offset 48
	movq	%r15, %rdx
	movq	%rbp, %rsi
	movl	%r13d, %edi
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	project
.L158:
	.cfi_restore_state
	vmovss	172(%rsp), %xmm1
	movq	56(%rsp), %rcx
	movl	%edx, %edx
	xorl	%eax, %eax
.L166:
	vmovss	(%rbx,%rax,4), %xmm0
	vfmadd213ss	(%rcx,%rax,4), %xmm1, %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	incq	%rax
	cmpq	%rdx, %rax
	jne	.L166
	jmp	.L162
.L150:
	vmovss	172(%rsp), %xmm1
	movq	176(%rsp), %rdi
	movl	%edx, %ecx
	xorl	%eax, %eax
	movq	184(%rsp), %r8
.L156:
	vmovss	(%r8,%rax,4), %xmm0
	vfmadd213ss	(%rdi,%rax,4), %xmm1, %xmm0
	vmovss	%xmm0, (%rdi,%rax,4)
	incq	%rax
	cmpq	%rax, %rcx
	jne	.L156
	jmp	.L157
.L172:
	movl	%edx, %edi
	xorl	%eax, %eax
	jmp	.L151
.L173:
	xorl	%eax, %eax
	jmp	.L159
	.cfi_endproc
.LFE5499:
	.size	vel_step, .-vel_step
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1065353216
	.align 4
.LC1:
	.long	1056964608
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC2:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.section	.rodata.cst4
	.align 4
.LC3:
	.long	-1090519040
	.align 4
.LC5:
	.long	1082130432
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
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
