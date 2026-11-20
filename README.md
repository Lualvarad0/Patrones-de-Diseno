# Patrones de Diseño en 7 Lenguajes

Este repositorio enseña los 23 patrones de diseño de GoF (Gang of Four) con
ejemplos **simples y ejecutables**, cada uno escrito en 7 lenguajes distintos:
C#, Java, JavaScript, Rust, C++, PHP y COBOL.

## ¿Qué es un patrón de diseño?

Es una solución ya probada para un problema que se repite muy seguido al
programar (por ejemplo: "necesito que solo exista una instancia de esta
clase en todo el programa", o "quiero agregarle comportamiento a un objeto
sin modificar su clase"). No es una librería que se instala ni código que
se copia y pega tal cual — es una *idea* o forma de organizar las clases
que cada lenguaje termina expresando a su manera.

Por eso este repositorio no repite la teoría (ya hay libros enteros sobre
eso), sino que muestra **cómo se ve ese mismo patrón, resuelto con el mínimo
código posible**, en lenguajes muy distintos entre sí — sin frameworks,
sin dependencias extra y sin complicaciones que no hagan falta para
entender la idea central.

## ¿Por dónde empiezo?

Si nunca viste un patrón de diseño, estos tres son el mejor punto de
partida porque son los más intuitivos:

1. [Singleton](patterns/creational/singleton/README.md) — una sola
   instancia compartida por todo el programa.
2. [Strategy](patterns/behavioral/strategy/README.md) — intercambiar un
   comportamiento (un algoritmo) sin tocar el código que lo usa.
3. [Observer](patterns/behavioral/observer/README.md) — avisar a varios
   objetos automáticamente cuando algo cambia.

Desde ahí podés explorar el resto en el orden que quieras: cada patrón es
independiente de los demás.

## Cómo está organizado

Las carpetas están agrupadas por **categoría** y luego por **patrón** —
nunca por lenguaje. La idea es que para estudiar, por ejemplo, Singleton,
entres a una sola carpeta y ahí tengas las 7 versiones una al lado de la
otra, fáciles de comparar:

```
patterns/
  creational/              <- patrones sobre CÓMO SE CREAN los objetos
    singleton/
      README.md            <- explica el patrón en español (problema, solución, cuándo usarlo)
      csharp/               <- la misma idea, escrita en C#
      java/                 <- ...en Java
      javascript/           <- ...en JavaScript
      rust/                 <- ...en Rust
      cpp/                  <- ...en C++
      php/                  <- ...en PHP
      cobol/                <- ...en COBOL
    factory-method/
    abstract-factory/
    builder/
    prototype/
  structural/              <- patrones sobre CÓMO SE COMBINAN/COMPONEN los objetos
    adapter/
    bridge/
    composite/
    decorator/
    facade/
    flyweight/
    proxy/
  behavioral/              <- patrones sobre CÓMO SE COMUNICAN/COMPORTAN los objetos
    chain-of-responsibility/
    command/
    interpreter/
    iterator/
    mediator/
    memento/
    observer/
    state/
    strategy/
    template-method/
    visitor/
```

Es decir, cada una de las 23 carpetas de patrón (p. ej. `singleton/`) tiene
exactamente la misma forma por dentro: un `README.md` que explica el
patrón sin depender de ningún lenguaje en particular, y una subcarpeta por
cada uno de los 7 lenguajes con el código y algún comentario puntual sobre
cómo se adapta la idea a ese lenguaje.

## Estado actual

Los 23 patrones de GoF ya tienen código funcionando en los 7 lenguajes
(✅ = hay un ejemplo completo y probado en esa carpeta).

| Categoría   | Patrón                  | C# | Java | JS | Rust | C++ | PHP | COBOL |
|-------------|--------------------------|----|------|----|------|-----|-----|-------|
| Creacional  | Singleton                | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Creacional  | Factory Method           | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Creacional  | Abstract Factory         | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Creacional  | Builder                  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Creacional  | Prototype                | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Adapter                  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Decorator                | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Bridge                   | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Composite                | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Facade                   | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Flyweight                | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Estructural | Proxy                    | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Strategy                 | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Observer                 | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Chain of Responsibility  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Command                  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Interpreter              | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Iterator                 | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Mediator                 | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Memento                  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | State                    | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Template Method          | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |
| Comportam.  | Visitor                  | ✅ | ✅   | ✅ | ✅   | ✅  | ✅  | ✅    |

✅ implementado

## Frameworks

Más adelante se añadirá una sección `frameworks/` mostrando estos mismos
patrones (o las variantes que cada framework ya resuelve por ti) en contextos
reales: ASP.NET Core, Spring, Laravel, React/Angular, Express, etc.

## Cómo ejecutar cada ejemplo

Cada carpeta de lenguaje tiene instrucciones puntuales en su propio código
(comentario al inicio del archivo) o un `README.md` corto si hace falta más
de un paso. En general:

| Lenguaje   | Requisito                         | Ejecutar                                |
|------------|------------------------------------|------------------------------------------|
| C#         | .NET SDK 8+                        | `dotnet run` dentro de la carpeta         |
| Java       | JDK 17+                            | `java NombreArchivo.java`                 |
| JavaScript | Node.js 18+                        | `node archivo.js`                         |
| Rust       | rustc / cargo                      | `rustc archivo.rs && ./archivo`           |
| C++        | g++ (C++17)                        | `g++ -std=c++17 archivo.cpp -o out && ./out` |
| PHP        | PHP 8+                             | `php archivo.php`                         |
| COBOL      | GnuCOBOL (con soporte OO: `cobc -x`) | `cobc -x -free archivo.cbl && ./archivo` |

## Contribuir

¿Quieres añadir un patrón o un lenguaje que falta? Lee
[CONTRIBUTING.md](CONTRIBUTING.md) — la idea es mantener cada ejemplo lo más
simple posible, con el mínimo código necesario para ver el patrón en acción.

## Licencia

[MIT](LICENSE)
