# Decorator

**Categoría:** Estructural

## Problema

Quieres añadir comportamiento extra a un objeto (por ejemplo, "este café
también lleva leche y también lleva caramelo") sin modificar su clase y
sin generar una explosión combinatoria de subclases
(`CafeConLecheYCaramelo`, `CafeConLeche`, `CafeConCaramelo`...).

## Solución

Creas envoltorios (decoradores) que implementan la misma interfaz que el
objeto original, mantienen una referencia a él, y añaden su propio
comportamiento antes o después de delegarle la llamada. Los decoradores se
pueden **anidar/apilar** en cualquier combinación.

## Cuándo usarlo

- Agregar responsabilidades a objetos individuales de forma dinámica y
  combinable, sin afectar a otros objetos de la misma clase.
- Alternativa a la herencia cuando extender por herencia generaría
  demasiadas subclases.

## Cuándo NO usarlo

- Si solo necesitas una combinación fija de comportamiento, una clase
  normal (o composición simple) es más clara que varias capas de
  decoradores apilados.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
