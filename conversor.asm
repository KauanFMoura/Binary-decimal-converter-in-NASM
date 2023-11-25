%include "asm_io.inc"

section .data
    entrada_1 db "Informe o que Deseja Fazer!", 0 
    entrada_2 db "1 - Converter Decimal para Binario", 0 
    entrada_3 db "2 - Converter Binario para Decimal", 0 

section .bss
    escolha resd 1

section .text
    extern binario_para_decimal
    extern decimal_para_binario
    global _asm_main    
_asm_main:
    enter 0,0
    pusha

    mov eax, entrada_1
    call print_string
    call print_nl

    mov eax, entrada_2
    call print_string
    call print_nl

    mov eax, entrada_3
    call print_string
    call print_nl

    call read_int
    mov [escolha], eax

    cmp eax, 1
    je decimal
    cmp eax, 2
    je binario

    jmp fim

decimal: 
    call decimal_para_binario
    jmp fim

binario:
    call binario_para_decimal
    jmp fim

fim:
    ; Não modifique o código após este comentário
    popa
    mov eax, 0
    leave
    ret
