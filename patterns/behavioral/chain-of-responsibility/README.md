# Chain of Responsibility

**Categoría:** Comportamiento

## Problema

Una petición puede necesitar ser manejada por **uno de varios manejadores
posibles**, pero no sabes de antemano cuál exactamente, y no quieres que
quien envía la petición conozca toda la lista de manejadores ni el orden
en que deben intentarlo.

## Solución

Encadenas los manejadores en una lista enlazada: cada manejador implementa
una interfaz común (`manejar(peticion)`), decide si puede resolverla, y si
no puede, la pasa al siguiente de la cadena. Quien envía la petición solo
conoce el primer eslabón.

## Cuándo usarlo

- Middleware HTTP, validación en pasos, sistemas de soporte con niveles de
  escalamiento (nivel 1 → nivel 2 → nivel 3), manejo de eventos de UI que
  "burbujean".

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
