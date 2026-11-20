# Template Method

**Categoría:** Comportamiento

## Problema

Varias clases comparten el **mismo esqueleto de algoritmo** (preparar →
procesar → finalizar), pero uno o más de esos pasos varía según la
subclase, y terminas duplicando el esqueleto completo en cada una solo
para cambiar un paso.

## Solución

En la clase base defines el método "plantilla" con el esqueleto completo
del algoritmo, llamando a métodos (algunos con implementación por
defecto, otros abstractos) que las subclases sobrescriben para los pasos
que varían. El orden y la estructura general del algoritmo quedan fijos
en la clase base; solo los pasos "variables" cambian.

## Cuándo usarlo

- Cuando el flujo general de un algoritmo es siempre el mismo y solo
  cambian pasos específicos entre variantes.

## Diferencia con Strategy

Template Method usa herencia (las subclases redefinen pasos del
algoritmo); Strategy usa composición (inyectas un objeto que *es* el
algoritmo completo). Template Method es más rígido pero requiere menos
código para variantes pequeñas.

## Dónde lo vas a encontrar en la vida real

- Los frameworks de testing (JUnit, xUnit, Jest): siempre ejecutan
  `setUp() → test() → tearDown()` en ese orden fijo; vos solo escribís el
  `test()`.
- Los Servlets de Java: el framework llama siempre a `service()`, que a su
  vez llama a tu `doGet()` o `doPost()` — el orden general nunca lo escribís
  vos.
- `Arrays.sort()`: el algoritmo de ordenamiento está fijo, pero llama a tu
  `compareTo()` para decidir el único paso que cambia.
- Los pipelines de integración continua (CI): casi todos siguen el mismo
  esqueleto (checkout → instalar → build → test → deploy) y cada proyecto
  solo cambia los comandos de cada paso.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
