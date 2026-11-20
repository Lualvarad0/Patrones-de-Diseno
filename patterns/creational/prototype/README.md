# Prototype

**Categoría:** Creacional

## Problema

Necesitás una copia independiente de un objeto (`Sheep`, en los ejemplos de
este repo) en varios lugares del código: un botón de "Duplicar", un
endpoint, un test. Sin Prototype, cada uno de esos lugares arma la copia a
mano, campo por campo (`new Sheep(original.Name, original.Color)`). Eso
funciona hasta que la clase crece y le agregás un campo nuevo — todos esos
lugares que copiaban "a mano" siguen copiando solo los campos viejos, y
nadie se entera hasta que alguien nota datos raros en producción. Crear un
objeto nuevo desde cero también puede ser caro (consulta a base de datos,
cálculo pesado) cuando ya tenés uno "casi igual" a mano.

## Solución

El objeto implementa un método `clone()` (o equivalente) que sabe copiarse
a sí mismo — incluyendo manejar correctamente copia superficial vs. copia
profunda de sus campos internos. El cliente pide una copia sin necesitar
conocer la clase exacta ni cómo se construye.

## Cuándo usarlo

- Cuando instanciar un objeto es costoso y ya tienes uno similar a mano.
- Cuando quieres reducir el número de subclases dedicadas solo a crear
  variantes preconfiguradas (puedes tener prototipos preconfigurados en vez
  de subclases).

## Cuidado con

- Copia superficial (shallow) vs. profunda (deep): si el objeto tiene
  referencias a otros objetos mutables, una copia superficial puede hacer
  que ambos objetos terminen compartiendo (y corrompiendo) el mismo estado.

## Dónde lo vas a encontrar en la vida real

- La herencia prototípica de JavaScript (`Object.create`, `__proto__`): el
  lenguaje entero está armado sobre la idea de clonar un objeto existente en
  vez de instanciar una clase.
- `Cloneable` en Java o `ICloneable` en .NET, usados para duplicar objetos de
  configuración o de dominio sin reconstruirlos desde cero.
- Videojuegos: generar un enemigo nuevo clonando una plantilla ya configurada
  (vida, sprite, hitbox) en vez de armarla desde cero cada vez.
- Duplicar un elemento con Ctrl+D en herramientas de diseño (Figma,
  Illustrator, PowerPoint): el elemento nuevo es un clon del original.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
