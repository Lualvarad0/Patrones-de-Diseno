# Decorator

**Categoría:** Estructural

## Problema

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción final. Si modelás cada
combinación como una subclase (`CafeConLeche`, `CafeConLecheYAzucar`,
`CafeConAzucar`...), con solo 2 extras ya tenés 4 clases, y cuando el
negocio pide sumar un tercer y cuarto extra (crema, shot extra) la cantidad
de clases se duplica en cada paso — 16 combinaciones posibles con 4 extras,
aunque la única diferencia real entre ellas sea sumar un precio y concatenar
un texto a la descripción.

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

## Dónde lo vas a encontrar en la vida real

- Los streams de Java: envolver un `FileInputStream` con un
  `BufferedInputStream` y después con un `GZIPInputStream`, cada capa
  agregando una funcionalidad.
- El middleware de Express.js o ASP.NET Core: cada middleware "envuelve" al
  siguiente, agregando logging, autenticación o compresión antes de llegar
  al handler real.
- Los componentes "styled" de styled-components o Material UI, que envuelven
  un componente base agregándole estilos sin tocar su código.
- Los decoradores (`@algo`) de Python o TypeScript, que envuelven una
  función o clase agregándole comportamiento extra.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
