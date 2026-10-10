| The second, shorter copy of the one-only section from oneonly-a.s.
	.section .text.inl,"ax"
	.weak	inl
inl:	jsr	inl
	rts
