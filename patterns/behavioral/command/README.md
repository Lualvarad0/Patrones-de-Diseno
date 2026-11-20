# Command

**Categoría:** Comportamiento

## Problema

Quieres tratar una **acción** (encender la luz, guardar un documento,
mover una pieza) como un objeto en sí mismo: poder guardarla en una cola,
loguearla, deshacerla (`undo`), o pasarla como parámetro — en vez de solo
poder ejecutarla inmediatamente llamando a un método.

## Solución

Encapsulas una petición en un objeto con una interfaz común
(`ejecutar()`, opcionalmente `deshacer()`), que guarda todo lo necesario
para ejecutarla (el receptor y sus parámetros). Quien dispara el comando
no necesita saber qué hace exactamente, solo llama a `ejecutar()`.

## Cuándo usarlo

- Implementar undo/redo.
- Colas de tareas, operaciones programadas o diferidas.
- Botones/menús de UI configurables donde cada acción es intercambiable.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
