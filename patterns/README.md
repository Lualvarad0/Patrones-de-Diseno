# Los patrones

Los 23 patrones de GoF (Gang of Four) están agrupados en 3 categorías según
qué parte del diseño resuelven: **cómo se crean** los objetos, **cómo se
combinan** entre sí, o **cómo se comunican/comportan**. Entrá a la categoría
que te interese, y de ahí a la carpeta del patrón puntual:

- [`creational/`](creational/README.md) — patrones de **creación**: formas
  de crear objetos sin acoplar el código a una clase concreta.
- [`structural/`](structural/README.md) — patrones **estructurales**: formas
  de combinar clases y objetos en estructuras más grandes.
- [`behavioral/`](behavioral/README.md) — patrones de **comportamiento**:
  formas en que los objetos se comunican y reparten responsabilidades.

Cada patrón vive en su propia carpeta (p. ej. `creational/singleton/`), con
un `README.md` que explica la idea en español —incluyendo dónde aparece ese
patrón en herramientas que probablemente ya usás sin darte cuenta— y una
subcarpeta por cada uno de los 7 lenguajes del repositorio (C#, Java,
JavaScript, Rust, C++, PHP, COBOL) con el código.

Si no sabés por dónde arrancar, el [README principal](../README.md#por-dónde-empiezo)
recomienda tres patrones para empezar.
