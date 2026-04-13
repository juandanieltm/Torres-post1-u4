; ============================================================
; programa.asm — Laboratorio Post1 Unidad 4
; Arquitectura de Computadores
; Propósito: demostrar directivas de sección (.data, .bss, .text),
;            definición de datos y salida por interrupciones DOS
;            usando INT 21h funciones 09h y 02h.
; Ensamblador: NASM 2.14+ (formato OMF/OBJ para DOS de 16 bits)
; Enlazador:   ALINK
; Entorno:     DOSBox 0.74+
; ============================================================

; ── Constantes (EQU — no reservan memoria) ──────────────────
CR          EQU 0Dh     ; Carriage Return
LF          EQU 0Ah     ; Line Feed
TERMINADOR  EQU 24h     ; '$' — terminador de cadena para DOS
ITERACIONES EQU 5       ; número de elementos en tabla_bytes

; ── Datos inicializados (.data) ─────────────────────────────
section .data

    bienvenida  db "=== Laboratorio NASM - Unidad 4 ===", CR, LF, TERMINADOR
    separador   db "----------------------------------------", CR, LF, TERMINADOR
    etiqueta_a  db "Variable A (byte): ", TERMINADOR
    etiqueta_b  db "Tabla de bytes:    ", TERMINADOR
    fin_msg     db CR, LF, "Programa finalizado correctamente.", CR, LF, TERMINADOR
    newline     db CR, LF, TERMINADOR

    ; Tipos de datos demostrados
    var_byte    db 42           ; 1 byte  — valor decimal 42 (0x2A)
    var_word    dw 1234h        ; 2 bytes — valor 0x1234
    var_dword   dd 0DEADBEEFh  ; 4 bytes — valor 0xDEADBEEF

    ; Tabla de 5 bytes (dígitos 1-5 → ASCII '1'-'5')
    tabla_bytes db 1, 2, 3, 4, 5

; ── Datos no inicializados (.bss) ───────────────────────────
section .bss

    buffer      resb 80     ; 80 bytes reservados para entrada futura
    resultado   resw 1      ; 1 word para almacenar un cálculo futuro

; ── Código ejecutable (.text) ───────────────────────────────
section .text

global main

main:
    ; ── Inicializar DS para acceder a la sección .data ──────
    mov ax, @data       ; valor del segmento de datos
    mov ds, ax          ; DS apunta a .data

    ; ── Imprimir mensaje de bienvenida ──────────────────────
    mov ah, 09h
    mov dx, bienvenida
    int 21h

    ; ── Imprimir separador ──────────────────────────────────
    mov ah, 09h
    mov dx, separador
    int 21h

    ; ── Imprimir etiqueta de var_byte ───────────────────────
    mov ah, 09h
    mov dx, etiqueta_a
    int 21h

    ; ── INT 21h función 02h: imprimir var_byte como dígito ASCII
    ; var_byte = 42; 42 + 30h = 72 → ASCII 'H'  (demo de conversión)
    mov al, [var_byte]  ; AL = 42 (0x2A)
    add al, 30h         ; convertir a ASCII
    mov ah, 02h
    mov dl, al
    int 21h

    ; ── Nueva línea ─────────────────────────────────────────
    mov ah, 02h
    mov dl, CR
    int 21h
    mov ah, 02h
    mov dl, LF
    int 21h

    ; ── Imprimir etiqueta de tabla ──────────────────────────
    mov ah, 09h
    mov dx, etiqueta_b
    int 21h

    ; ── Recorrer tabla_bytes e imprimir cada elemento ───────
    lea si, tabla_bytes     ; SI = dirección del primer elemento
    mov cx, ITERACIONES     ; CX = 5 repeticiones

imprimir_tabla:
    mov al, [si]            ; AL = byte actual
    add al, 30h             ; convertir a ASCII ('1','2',...,'5')
    mov ah, 02h
    mov dl, al
    int 21h                 ; imprimir el dígito

    mov ah, 02h             ; imprimir espacio separador
    mov dl, 20h
    int 21h

    inc si                  ; avanzar puntero
    loop imprimir_tabla     ; CX--; si CX != 0, repetir

    ; ── Imprimir mensaje de fin ─────────────────────────────
    mov ah, 09h
    mov dx, fin_msg
    int 21h

    ; ── Terminar programa (INT 21h función 4Ch) ─────────────
    mov ax, 4C00h           ; AH=4Ch terminar, AL=00h código de salida
    int 21h
