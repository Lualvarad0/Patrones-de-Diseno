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

## Dónde lo vas a encontrar en la vida real

- `document.createElement("div")` en el navegador: el mismo método crea
  objetos distintos según el string que le pases.
- `Calendar.getInstance()` en Java: te devuelve una subclase de `Calendar`
  distinta según la configuración regional, sin que vos elijas la clase.
- Los ORM que, al conectarte, deciden internamente qué clase de "driver"
  instanciar según la cadena de conexión (SQL Server, PostgreSQL, MySQL).
- Frameworks de UI con un método `createButton()` en una clase base que cada
  plataforma (Windows, Mac, Web) sobrescribe para devolver su propio botón.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
