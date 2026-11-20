# Abstract Factory

**Categoría:** Creacional

## Problema

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
widget decida su propia clase por separado, con un `if (tema == "oscuro")`
repetido antes de crear el botón y otro antes de crear el checkbox. Como
son dos decisiones independientes, un copy-paste apurado (o simplemente
olvidarse de uno de los `if`) puede dejar un botón oscuro al lado de un
checkbox claro en la misma pantalla — un bug visual que nadie detecta hasta
que alguien manda una captura rara. Necesitás **crear familias completas de
objetos relacionados** y garantizar que nunca se mezclen objetos de
familias distintas en el mismo contexto.

## Solución

Defines una interfaz de fábrica con un método de creación por cada tipo de
producto de la familia (`createButton()`, `createCheckbox()`), y una
implementación concreta de esa fábrica por cada familia. El cliente recibe
una fábrica concreta (normalmente por configuración o inyección) y crea
todo a través de ella, sin saber qué familia es.

## Cuándo usarlo

- Cuando tu sistema debe ser independiente de cómo se crean, componen y
  representan sus productos, y necesitas garantizar consistencia entre
  productos relacionados (mismo tema, mismo motor gráfico, mismo proveedor
  de base de datos).

## Relación con Factory Method

Una Abstract Factory suele implementarse usando varios Factory Methods, uno
por producto.

## Dónde lo vas a encontrar en la vida real

- Los temas claro/oscuro de una app: una sola fábrica crea todos los
  botones, checkboxes y campos de texto que combinan entre sí (nunca un
  botón "claro" con un checkbox "oscuro").
- `DbProviderFactory` en .NET: según el proveedor configurado (SQL Server,
  PostgreSQL), crea la conexión, el comando y el adaptador correctos, todos
  compatibles entre sí.
- Los antiguos kits de UI multiplataforma (Swing look-and-feel, wxWidgets)
  que arman toda una familia de widgets coherente con el sistema operativo.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
