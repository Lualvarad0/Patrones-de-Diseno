# Composite

**Categoría:** Estructural

## Problema

Tienes una estructura de **árbol** (carpetas con archivos y subcarpetas,
un menú con submenús, elementos UI que contienen otros elementos) y
quieres tratar objetos individuales (hojas) y grupos de objetos
(contenedores) **de la misma forma**, sin que el código cliente tenga que
preguntar constantemente "¿esto es una hoja o un grupo?".

## Solución

Defines una interfaz común para hojas y contenedores (ej. `mostrar()`,
`calcularTamaño()`). El contenedor implementa esa misma interfaz
delegando/agregando el resultado de llamar al mismo método en cada uno de
sus hijos (que pueden ser hojas u otros contenedores). El cliente llama al
método en la raíz y la recursión ocurre sola.

## Cuándo usarlo

- Cualquier estructura jerárquica tipo árbol donde quieres operar sobre el
  todo y sobre las partes de manera uniforme.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
