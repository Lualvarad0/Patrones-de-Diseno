# Design Patterns Polyglot

Aprende los 23 patrones de diseño de GoF (Gang of Four) con ejemplos **simples y
ejecutables** en varios lenguajes: C#, Java, JavaScript, Rust, C++, PHP y COBOL.

La idea de este repositorio no es repetir la teoría de los patrones (ya hay
mil libros y artículos sobre eso), sino mostrar **cómo se ven realmente** en
cada lenguaje, con el mínimo código necesario para entender la idea — sin
frameworks de por medio, sin dependencias raras, sin "enterprise-itis".

## Cómo está organizado

```
patterns/
  creational/
    singleton/
      README.md          <- explicación del patrón (problema, solución, cuándo usarlo)
      csharp/
      java/
      javascript/
      rust/
      cpp/
      php/
      cobol/
    factory-method/
    abstract-factory/
    builder/
    prototype/
  structural/
    adapter/
    bridge/
    composite/
    decorator/
    facade/
    flyweight/
    proxy/
  behavioral/
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

Cada carpeta de patrón tiene un `README.md` explicando el patrón en sí
(independiente del lenguaje), y una subcarpeta por lenguaje con el código
y comentarios sobre las particularidades de implementarlo ahí.

## Estado actual

Los 23 patrones de GoF están implementados en los 7 lenguajes.

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
