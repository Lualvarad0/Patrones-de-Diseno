# Prototype

**Categoría:** Creacional

## Problema

Crear un objeto nuevo desde cero es caro (consulta a base de datos, cálculo
pesado) o simplemente quieres un objeto "casi igual" a otro que ya existe,
con un par de campos distintos, sin acoplarte a su clase concreta para
poder copiarlo.

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

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
