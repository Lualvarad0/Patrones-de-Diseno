# Flyweight

**Categoría:** Estructural

## Problema

Necesitas crear una **cantidad enorme** de objetos similares (árboles en
un bosque renderizado, caracteres de texto, partículas) y crear uno
distinto por cada uno consume demasiada memoria, aunque la mayor parte de
su estado se repite entre todos.

## Solución

Separas el estado de cada objeto en:
- **Estado intrínseco**: lo que es igual entre muchas instancias (la
  textura y modelo 3D de "árbol de pino") — se comparte en un único objeto
  "flyweight", normalmente cacheado en una fábrica.
- **Estado extrínseco**: lo que varía por instancia (posición x/y en el
  mapa) — se pasa como parámetro desde fuera cada vez que se necesita, en
  vez de guardarse dentro del objeto compartido.

## Cuándo usarlo

- Cuando el número de objetos es muy grande y el costo de memoria es un
  problema real medido, no solo una sospecha.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
