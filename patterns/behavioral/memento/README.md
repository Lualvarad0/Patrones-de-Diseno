# Memento

**Categoría:** Comportamiento

## Problema

Quieres poder guardar y restaurar el estado anterior de un objeto (un
"undo" de un editor de texto, un checkpoint de juego) sin romper su
encapsulación — es decir, sin exponer todos sus campos internos al
código externo que gestiona el historial.

## Solución

El objeto (el "originador") sabe crear una instantánea de su propio
estado (`crearMemento()`) y restaurarse a partir de una
(`restaurar(memento)`). El memento en sí es opaco para quien lo guarda
(normalmente un "cuidador" que solo lo almacena en una pila/lista, sin
mirar ni modificar su contenido).

## Cuándo usarlo

- Implementar undo/redo o checkpoints de forma que el historial no
  necesite conocer los detalles internos del objeto que respalda.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
