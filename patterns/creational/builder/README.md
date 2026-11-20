# Builder

**Categoría:** Creacional

## Problema

Tu app de delivery de pizzas modela cada pizza con un constructor que
recibe todos los ingredientes como parámetros booleanos:
`new Pizza("large", true, false, true, false, true, false)`. Nadie puede
leer qué lleva esa pizza sin ir a contar posiciones en la firma del
constructor, y si el negocio agrega un ingrediente nuevo en el medio de la
lista, todos los lugares del código que crean una pizza quedan con sus
argumentos corridos de lugar — sin que el compilador avise, porque
`true`/`false` encaja en cualquier posición booleana.

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

## Dónde lo vas a encontrar en la vida real

- `StringBuilder` en Java/C#: arma un string largo paso a paso en vez de
  concatenar strings inmutables una y otra vez.
- El "query builder" de Laravel (Eloquent), Entity Framework o Knex.js:
  encadenás `.where().orderBy().limit()` y al final se arma la consulta SQL.
- `AlertDialog.Builder` en Android, o `Request.Builder` de OkHttp: configurás
  opción por opción algo que tiene demasiados parámetros opcionales para un
  constructor normal.
- La anotación `@Builder` de Lombok en Java, que genera automáticamente esta
  clase por vos.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
