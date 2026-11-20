# Patrones de creación (Creational)

Resuelven un mismo problema: **cómo crear objetos** sin que el resto del
código quede acoplado a una clase concreta, a cómo se arma ese objeto, o a
cuántas instancias de él pueden existir. En vez de escribir `new ClaseX()`
por todos lados, delegás esa decisión a otra pieza del código.

| Patrón | En una frase |
|--------|--------------|
| [Singleton](singleton/README.md) | Una sola instancia compartida por todo el programa. |
| [Factory Method](factory-method/README.md) | Delegar a las subclases qué clase concreta instanciar. |
| [Abstract Factory](abstract-factory/README.md) | Crear familias completas de objetos relacionados entre sí. |
| [Builder](builder/README.md) | Armar un objeto complejo paso a paso, de forma legible. |
| [Prototype](prototype/README.md) | Crear un objeto nuevo clonando uno existente. |

Volver al [índice de patrones](../README.md).
