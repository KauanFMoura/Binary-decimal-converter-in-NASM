%include "asm_io.inc"

section .data
    entrada_1 db "Informe um número binario: ", 0 
    saida_1 db "Número Decimal: ", 0 

section .bss
    valor_decimal resd 1 
    valor_binario resd 1
    resto resd 1
    contador resd 1
    p_contador resd 1

section .text
    global binario_para_decimal    
binario_para_decimal:
    enter 0,0
    pusha

    mov eax, entrada_1
    call print_string
    call read_int
    mov [valor_binario], eax

    mov eax, 10
    mov ebx, eax

    mov eax, 0
    mov [contador], eax
    mov [valor_decimal], eax

    jmp converter_binario

converter_binario:
    mov eax, [valor_binario]
    cmp eax, 0
    je fim

    xor edx, edx  ; Limpa edx antes da divisão
    idiv ebx

    mov [valor_binario], eax
    mov eax, edx
    mov [resto], eax

    mov eax, 2
    mov [p_contador], eax

    mov ecx, [contador]
    cmp ecx, 0
    je elevado_zero
    cmp ecx, 1
    je continua
    jmp elevado_normal
    
elevado_zero:
    mov eax, 1
    mov [p_contador], eax
    jmp continua

elevado_normal:
    cmp ecx, 1
    je continua

    mov eax, [p_contador]
    imul eax, 2
    mov [p_contador], eax 
    
    dec ecx
    jmp elevado_normal

continua:
    mov eax, [resto]
    imul eax, [p_contador]
    
    add eax, [valor_decimal]
    mov [valor_decimal], eax
    
    mov eax, [contador]
    inc eax
    mov [contador], eax

    jmp converter_binario

fim:
    mov eax, saida_1
    call print_string
    mov eax, [valor_decimal]
    call print_int
    call print_nl

    ; Não modifique o código após este comentário
    popa
    mov eax, 0
    leave
    ret
