# INSTRUCCIONES PARA SUBIR A GITHUB
# Cambia "apellido" por tu apellido real antes de ejecutar.
# Ejecuta estos comandos en la terminal del sistema operativo (NO en DOSBox).

# ── 1. Inicializar repo y renombrar carpeta ──────────────────────────────────
# (Opcional si ya clonaste el repo vacío desde GitHub)
git init
git branch -M main

# ── 2. Commit 1 — Estructura inicial ────────────────────────────────────────
git add README.md .gitignore
git commit -m "Inicializar repositorio laboratorio Post1 U4"

# ── 3. Commit 2 — Código fuente base ────────────────────────────────────────
git add programa.asm
git commit -m "Implementar programa base con secciones .data, .bss y .text"

# ── 4. Commit 3 — Versión funcional con capturas ────────────────────────────
git add capturas/
git commit -m "Agregar salida de caracteres con INT 21h func 02h y recorrido de tabla"

# ── 5. Conectar con GitHub y subir ──────────────────────────────────────────
# Reemplaza la URL por la de tu repositorio GitHub
git remote add origin https://github.com/TU_USUARIO/apellido-post1-u4.git
git push -u origin main

# ── Verificar historial de commits ──────────────────────────────────────────
git log --oneline
