%include "asm_io.inc"

section .data
entrada_1 db "Informe um número Decimal: ", 0 
saida_1 db "Número Binario: ", 0 
array_binario times 32 dd 2

section .bss
valor_decimal resd 1 
contador resd  1

section .text
    global decimal_para_binario    
decimal_para_binario:
    enter 0,0
    pusha

    mov eax, entrada_1
    call print_string
    call read_int
    mov [valor_decimal], eax

    mov eax, 2
    mov ebx, eax
    
    mov eax, 31
    mov [contador], eax

    jmp converter_decimal

converter_decimal:
    xor edx, edx  ; Limpa edx antes da divisão
    mov eax, [valor_decimal]
    idiv ebx

    mov [valor_decimal], eax
    cmp edx, 0
    je guarda_zero
    jmp guarda_um

guarda_zero:
    mov eax, 0
    mov ecx, [contador]
    mov [array_binario + ecx*4], eax ; Usar *4 para ajustar para dword (4 bytes)
    jmp decremanta_contador

guarda_um:
    mov eax, 1
    mov ecx, [contador]
    mov [array_binario + ecx*4], eax ; Usar *4 para ajustar para dword (4 bytes)
    jmp decremanta_contador

decremanta_contador:
    mov eax, [contador]
    dec eax
    mov [contador], eax
    jmp verifica

verifica:
    mov eax, [valor_decimal]
    cmp eax, 0
    je printa_array
    jmp converter_decimal

printa_array: 
    mov eax, saida_1
    call print_string

    mov ebx, array_binario
    mov eax, 0
    mov [contador], eax
    jmp imprime_binario

imprime_binario:
    mov ecx, [contador]
    mov eax, [ebx + ecx*4]  
    cmp eax, 2            
    je proxima_posicao    

    call print_int        
    jmp proxima_posicao

proxima_posicao:
    mov eax, [contador]
    inc eax             
    mov [contador], eax
    cmp eax, 31
    je fim
    jmp imprime_binario  

fim:
    call print_nl

    ; Não modifique o código após este comentário
    popa
    mov eax, 0
    leave
    ret
