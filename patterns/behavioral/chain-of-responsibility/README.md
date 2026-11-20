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

## Dónde lo vas a encontrar en la vida real

- Cada middleware de Express.js o del pipeline de ASP.NET Core: decide si
  maneja la petición o la pasa al siguiente con `next()`.
- Un clic en una página web "burbujea" de elemento en elemento hasta el
  `document`, a menos que algo llame a `stopPropagation()`.
- Un sistema de soporte técnico con niveles de escalamiento: nivel 1 intenta
  resolver, si no puede lo pasa a nivel 2, y así.
- Los "appenders" encadenados de Log4j o los filtros de un `HttpHandler`,
  donde cada uno decide si procesa el log/petición o lo deja pasar.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
