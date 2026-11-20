# Bridge

**Categoría:** Estructural

## Problema

Tienes una jerarquía de clases que crece en dos dimensiones distintas a la
vez (por ejemplo, `Forma` × `MotorDeRenderizado`, o `ControlRemoto` ×
`TipoDeDispositivo`) y usar solo herencia te obliga a crear una subclase
por cada combinación posible.

## Solución

Separas la **abstracción** (lo que el cliente usa, ej. `ControlRemoto`) de
su **implementación** (el "cómo", ej. `Dispositivo`) en dos jerarquías de
clases independientes, unidas por composición: la abstracción contiene una
referencia a un objeto de la jerarquía de implementación en vez de heredar
de ella. Así cada dimensión crece por su lado.

## Cuándo usarlo

- Cuando quieres poder cambiar la implementación en tiempo de ejecución sin
  tocar el código que usa la abstracción.
- Cuando una jerarquía de herencia simple te está llevando a una
  combinatoria de subclases.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
