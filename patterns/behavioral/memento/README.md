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

## Dónde lo vas a encontrar en la vida real

- El Ctrl+Z de cualquier editor de texto o de diseño: cada paso de undo es
  una "foto" guardada del estado anterior del documento.
- Los puntos de guardado (checkpoints) de un videojuego: restauran tu
  progreso sin que el sistema de guardado necesite entender toda la lógica
  interna del juego.
- Los "savepoints" de una transacción de base de datos: podés volver a un
  punto intermedio sin deshacer toda la transacción.
- El autoguardado de borradores en Gmail o Google Docs, que te deja
  recuperar una versión anterior del texto.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
