# Torres-post1-u4

## Descripción

Laboratorio 1 de la Unidad 4 — **Segmentos, Directivas y Salida por Interrupciones DOS**.

Este proyecto demuestra la estructura básica de un programa ensamblador NASM de 16 bits para entorno DOS, incluyendo:

- Uso de las tres secciones principales: `.data`, `.bss` y `.text`
- Definición de datos con directivas `db`, `dw`, `dd`, `resb`, `resw` y `EQU`
- Salida por pantalla mediante la interrupción DOS `INT 21h`:
  - **Función 09h** — imprimir cadena terminada en `$`
  - **Función 02h** — imprimir un carácter individual
- Recorrido de una tabla de bytes usando un bucle con la instrucción `LOOP`
- Terminación limpia del programa con `INT 21h` función `4Ch`

---

## Prerrequisitos

| Herramienta | Versión mínima | Descripción |
|-------------|----------------|-------------|
| [DOSBox](https://www.dosbox.com/) | 0.74+ | Emulador de entorno DOS de 16 bits |
| [NASM](https://www.nasm.us/) | 2.14+ | Ensamblador (Netwide Assembler) |
| [ALINK](http://alink.sourceforge.net/) | 1.6+ | Enlazador compatible con formato OMF |

### Estructura de archivos en la carpeta de trabajo (host)

```
Torres-post1-u4\
├── nasm.exe          ← ejecutable de NASM
├── alink.exe         ← ejecutable de ALINK
├── programa.asm      ← código fuente (este repositorio)
├── README.md         ← este archivo
└── capturas\
    ├── compilacion.png   ← captura de compilación exitosa
    └── ejecucion.png     ← captura de ejecución en DOSBox
```

---

## Compilación y Ejecución

### 1. Montar la carpeta en DOSBox

Abrir DOSBox y ejecutar:

```dosbox
mount C C:\ruta\a\apellido-post1-u4
C:
```

Verificar que NASM está disponible:

```dosbox
nasm -v
```

### 2. Ensamblar

```dosbox
nasm -f obj programa.asm -o programa.obj
```

Si el ensamblado es exitoso, aparecerá el archivo `programa.obj` en el directorio.  
En caso de error, NASM reporta el número de línea exacto, por ejemplo:
```
programa.asm:12: error: parser: instruction expected
```

### 3. Enlazar

```dosbox
alink programa.obj -oEXE -o programa.exe -entry main
```

### 4. Ejecutar

```dosbox
programa.exe
```

### Salida esperada

```
=== Laboratorio NASM - Unidad 4 ===
----------------------------------------
Variable A (byte): H
Tabla de bytes:    1 2 3 4 5
Programa finalizado correctamente.
```

> **Nota:** El carácter `H` proviene de convertir `var_byte = 42` a ASCII (`42 + 48 = 72 → 'H'`).  
> Los elementos de la tabla (`1 2 3 4 5`) son los bytes `1,2,3,4,5` convertidos a sus dígitos ASCII.

---

## Estructura del Código

| Sección | Contenido |
|---------|-----------|
| `.data` | Cadenas de texto, `var_byte`, `var_word`, `var_dword`, `tabla_bytes` |
| `.bss`  | `buffer` (80 bytes sin inicializar), `resultado` (1 word) |
| `.text` | Código ejecutable: inicialización de `DS`, llamadas a `INT 21h`, bucle |

### Constantes EQU utilizadas

```nasm
CR          EQU 0Dh   ; Carriage Return
LF          EQU 0Ah   ; Line Feed
TERMINADOR  EQU 24h   ; '$' para INT 21h función 09h
ITERACIONES EQU 5     ; tamaño de tabla_bytes
```

---

## Historial de Commits

| # | Mensaje | Descripción |
|---|---------|-------------|
| 1 | `Inicializar repositorio laboratorio Post1 U4` | Estructura inicial y README |
| 2 | `Implementar programa base con secciones .data, .bss y .text` | Código fuente con segmentos y datos |
| 3 | `Agregar salida de caracteres con INT 21h func 02h y recorrido de tabla` | Versión funcional completa |

---

## Capturas de Pantalla

Las capturas se encuentran en la carpeta `capturas/`:

- `compilacion.png` — compilación y enlazado exitoso en DOSBox
- `ejecucion.png` — ejecución de `programa.exe` con salida esperada

---

## Autor

Laboratorio desarrollado para la asignatura **Arquitectura de Computadores** — Unidad 4.
