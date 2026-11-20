# Patrones de comportamiento (Behavioral)

Resuelven cómo se **comunican y reparten responsabilidades** los objetos
entre sí: quién le avisa a quién cuando algo cambia, cómo se pasa una
petición entre varios candidatos a resolverla, cómo se intercambia un
algoritmo por otro, etc.

| Patrón | En una frase |
|--------|--------------|
| [Chain of Responsibility](chain-of-responsibility/README.md) | Pasar una petición por una cadena de manejadores hasta que uno la resuelve. |
| [Command](command/README.md) | Convertir una acción en un objeto, para poder encolarla, deshacerla o guardarla. |
| [Interpreter](interpreter/README.md) | Definir una gramática simple e interpretarla. |
| [Iterator](iterator/README.md) | Recorrer una colección sin exponer cómo está armada por dentro. |
| [Mediator](mediator/README.md) | Centralizar la comunicación entre objetos para que no se hablen directamente entre sí. |
| [Memento](memento/README.md) | Guardar y restaurar el estado anterior de un objeto (deshacer). |
| [Observer](observer/README.md) | Avisar a varios objetos automáticamente cuando algo cambia. |
| [State](state/README.md) | Cambiar el comportamiento de un objeto según su estado interno. |
| [Strategy](strategy/README.md) | Intercambiar un algoritmo por otro sin tocar el código que lo usa. |
| [Template Method](template-method/README.md) | Fijar el esqueleto de un algoritmo y dejar que las subclases cambien un paso. |
| [Visitor](visitor/README.md) | Agregar operaciones nuevas a una jerarquía de clases sin modificarla. |

Volver al [índice de patrones](../README.md).
