# Builder

**Categoría:** Creacional

## Problema

Un objeto tiene muchos parámetros opcionales de construcción (piensa en un
`HttpRequest`, una `Pizza` con 10 ingredientes opcionales, un `Document`).
Un constructor con 10 parámetros, varios booleanos sueltos, o decenas de
constructores sobrecargados (`telescoping constructor`) es horrible de
leer y usar.

## Solución

Extraes la construcción paso a paso a una clase separada (`Builder`), con
métodos encadenables (`.setX().setY().build()`) que van configurando el
objeto y devuelven el builder mismo (o una copia), hasta un método final
`.build()` que entrega el objeto ya armado e inmutable.

## Cuándo usarlo

- Objetos con muchos parámetros opcionales donde quieres evitar
  constructores gigantes o configuraciones incompletas/inconsistentes a
  medio construir.
- Cuando quieres que el mismo proceso de construcción pueda producir
  distintas representaciones del objeto.

## Cuándo NO usarlo

- Si el objeto tiene 2-3 campos simples, usa un constructor normal o
  argumentos con nombre si el lenguaje los soporta.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
