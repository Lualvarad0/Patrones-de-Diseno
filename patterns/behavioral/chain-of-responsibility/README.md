# Chain of Responsibility

**Categoría:** Comportamiento

## Problema

Un ticket de soporte tiene que resolverse en el nivel que corresponda
según su severidad. Si una sola función concentra todas las reglas de
escalamiento (`if severity <= 1 ... else if severity <= 2 ...`), esa
función tiene que conocer los umbrales de todos los niveles a la vez, y
agregar un nivel nuevo significa editarla junto con cualquier otro lugar
del código que repita la misma lógica.

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
