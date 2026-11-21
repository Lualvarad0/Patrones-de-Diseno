# Los patrones

Los 23 patrones de GoF (Gang of Four) están agrupados en 3 categorías según
qué parte del diseño resuelven: **cómo se crean** los objetos, **cómo se
combinan** entre sí, o **cómo se comunican/comportan**. No son una lista de
"cosas que hay que usar" — son soluciones a problemas puntuales que vas a
reconocer en tu propio código cuando te pase lo que describe la columna
"Te das cuenta que lo necesitás cuando...".

| Categoría | Resuelve | Te das cuenta que lo necesitás cuando... | Momento típico |
|-----------|----------|-------------------------------------------|-----------------|
| [`creational/`](creational/README.md) — **creación** | Cómo se crean los objetos, sin acoplar el código a una clase concreta | Tenés `new ClaseX()` repetido por todos lados, un objeto que no debería tener más de una instancia, un constructor con demasiados parámetros opcionales, o necesitás que el código decida en tiempo de ejecución *qué clase concreta* instanciar | Al **diseñar** una clase nueva o un módulo que arma objetos — antes de que la lógica de creación se desparrame |
| [`structural/`](structural/README.md) — **estructural** | Cómo combinar clases y objetos en estructuras más grandes | Necesitás integrar una librería externa o código legado con una interfaz distinta a la tuya, una jerarquía de herencia te está llevando a una explosión de subclases, o querés tratar un objeto individual igual que a un grupo de ellos | Al **integrar** piezas que no fueron pensadas para encajar entre sí, o cuando la herencia empieza a complicar más de lo que ayuda |
| [`behavioral/`](behavioral/README.md) — **comportamiento** | Cómo se comunican y reparten responsabilidades los objetos entre sí | Tenés un `if`/`switch` enorme repetido en varios lugares, varias clases necesitan enterarse cuando algo cambia en otra, o un algoritmo cambia según el contexto pero el código que lo usa no debería saberlo | Cuando la **lógica de negocio crece** y empieza a mezclarse con decisiones de "quién hace qué y cuándo" |

Entrá a la categoría que te interese, y de ahí a la carpeta del patrón
puntual. Cada patrón vive en su propia carpeta (p. ej.
`creational/singleton/`), con un `README.md` que explica, en español:

- **Cuál es el problema concreto** que resuelve (no una definición abstracta).
- **Dónde aparece en la vida real**, en herramientas que probablemente ya
  usás sin darte cuenta.
- Una subcarpeta por cada uno de los 7 lenguajes del repositorio (C#, Java,
  JavaScript, Rust, C++, PHP, COBOL), cada una con el código **y** un
  README propio que muestra cómo se vería ese mismo problema sin el patrón
  aplicado, y cómo queda una vez aplicado.

Si no sabés por dónde arrancar, el [README principal](../README.md#por-dónde-empiezo)
recomienda tres patrones para empezar.
