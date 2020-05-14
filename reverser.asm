; this is a simple example for reversing
; an array using x86 intel 80386 assembly
.386 ; set directive to i386
.model flat,c ; tell assembler that we are using a flat memory segment model, and that we are using the c language
.code ; code section start
reverser proc ; create a procedure called reverser
		push ebp ; push base pointer, function frame, stuff like arguments are offseted from here
		mov ebp, esp ; mov esp into ebp, this starts the function prologue and will preserve stack frame
		push esi ; push source on the stack, see the C++ signature if you're having trouble understanding
		push edi ; pust destination on the stack, see the C++ signature if you're having trouble understanding

		xor eax, eax ; init to zero
		; tip: ebp + 4 is where the return address lies. this is so the assembly
		; knows where to return to after the procedure is done being ran
		mov edi, [ebp + 8] ; ebp + 8 is where the pointer to the destination array is
		mov esi, [ebp + 12] ; ebp + 12 is the offset where the pointer to the src array is
		mov ecx, [ebp + 16] ; mov the count register into the num_elements argument
		test ecx, ecx ; check if num elements is not zero
		jz done ; if num elements is zero it'll jump to the return and break out the procedure

		lea esi, [esi + ecx * 4 - 4] ; this will get the final index of esi (esi + num_elements), with scale factor of 4 for DWORD integers
		pushfd ; push flags
		std ; set direction flag to one which will decrement indexes (right to left)
	
@@:		lodsd ; start of loop
		mov [edi], eax ; mov eax into the dereferenced index at edi *(edi + offset)
		add edi, 4 ; run through the destination array
		dec ecx ; decrement counter
		jnz	@B ; jump back to start of loop while the counter is not zero

		popfd ; pop flags
		mov eax, 1 ; return 1

		pop edi ; procedure epilogue
		pop esi ; procedure epilogue
		pop ebp ; procedure epilogue
done:
		ret ; return the procedure
		
reverser endp ; end the procedure called reverser
end ; end code section
