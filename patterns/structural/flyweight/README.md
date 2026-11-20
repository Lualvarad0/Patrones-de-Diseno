# Flyweight

**Categoría:** Estructural

## Problema

Tu juego dibuja un bosque de un millón de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Si cada `Tree` guarda su propia copia
del nombre y el sprite, un millón de árboles significa un millón de copias
de esos datos — aunque solo haya 2 o 3 especies distintas de verdad. Si el
sprite pesa unos cuantos KB, esa duplicación se come la memoria por nada:
los datos son los mismos, solo cambia la posición de cada árbol.

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
