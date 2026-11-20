# Memento

**Categoría:** Comportamiento

## Problema

Tu editor de texto necesita un "deshacer". Si la forma obvia de guardar
un checkpoint es que el historial lea el contenido directamente
(`history.push(editor.content)`) y lo reescriba igual de directo al
deshacer, el historial necesita acceso de lectura y escritura al estado
interno del editor — y cualquier campo nuevo que el editor agregue
(cursor, selección, formato) tiene que replicarse también en el
historial.

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
