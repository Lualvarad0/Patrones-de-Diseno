# Factory Method

**Categoría:** Creacional

## Problema

Tienes código que crea objetos con `new ConcretaX()`, pero no quieres que
ese código dependa de la clase concreta exacta — quieres poder cambiarla o
añadir nuevas variantes sin tocar la lógica que las usa.

## Solución

En lugar de instanciar directamente, delegas la creación a un **método**
(normalmente en una clase base o interfaz) que las subclases sobrescriben
para decidir qué clase concreta crear. El código cliente solo conoce el
método de fábrica y el tipo abstracto que devuelve.

## Cuándo usarlo

- Cuando una clase no puede anticipar de qué subclase exacta necesita crear
  objetos.
- Cuando quieres que subclases decidan qué objetos instanciar (patrón
  "Template Method" aplicado a la creación).

## Cuándo NO usarlo

- Si solo tienes un tipo de producto y no prevés variantes, es
  sobre-ingeniería: un constructor normal o una función simple alcanza.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
