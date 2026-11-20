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

## Dónde lo vas a encontrar en la vida real

- JDBC en Java: tu código siempre usa `Connection`/`Statement`, pero por
  detrás cada base de datos (MySQL, PostgreSQL, Oracle) tiene su propio
  driver — la abstracción no sabe ni le importa cuál.
- Un control remoto universal que funciona con televisores de marcas
  distintas: el control (abstracción) y el dispositivo (implementación)
  varían cada uno por su lado.
- Motores gráficos que renderizan las mismas formas con OpenGL o DirectX
  según la plataforma, sin que el código de "dibujar un círculo" cambie.
- Los drivers de impresora: la misma acción de "imprimir documento" funciona
  con marcas y modelos completamente distintos por debajo.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
