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

## Dónde lo vas a encontrar en la vida real

- El "interning" de strings en Java, .NET y Python: dos strings literales
  idénticos comparten el mismo objeto en memoria en vez de duplicarse.
- Los editores de texto y procesadores de palabras: cada letra que ves en
  pantalla reutiliza el mismo objeto "glifo" de la fuente, solo cambia su
  posición.
- Videojuegos con miles de árboles, balas o partículas en pantalla: todos
  comparten el mismo modelo 3D y textura ("instancing"), solo varía su
  posición individual.
- Los íconos repetidos en una lista larga de una app (cientos de filas con
  el mismo ícono de carpeta): el ícono se carga una vez y se reutiliza.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
