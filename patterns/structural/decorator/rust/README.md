# Decorator en Rust

## El problema, en código

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción. El primer instinto es
resolverlo con un `struct` por combinación:

```rust
struct Coffee;
impl Coffee {
    fn description(&self) -> String { "Coffee".to_string() }
    fn cost(&self) -> f64 { 2.0 }
}

struct CoffeeWithMilk;
impl CoffeeWithMilk {
    fn description(&self) -> String { "Coffee + Milk".to_string() }
    fn cost(&self) -> f64 { 2.5 }
}

struct CoffeeWithSugar;
impl CoffeeWithSugar {
    fn description(&self) -> String { "Coffee + Sugar".to_string() }
    fn cost(&self) -> f64 { 2.2 }
}

struct CoffeeWithMilkAndSugar;
impl CoffeeWithMilkAndSugar {
    fn description(&self) -> String { "Coffee + Milk + Sugar".to_string() }
    fn cost(&self) -> f64 { 2.7 }
}
// y cuando el negocio pide sumar "crema" como quinto extra, cada
// combinación existente se duplica: CoffeeWithCrema, CoffeeWithMilkAndCrema...
```

Con solo 2 extras ya tenés 4 tipos. Con 4 extras (leche, azúcar, crema, shot
extra) son 16 combinaciones posibles, y agregar un quinto extra (canela)
duplica otra vez la cantidad de tipos que tendrías que escribir y
mantener — aunque la única diferencia real entre ellos sea sumar un precio y
concatenar un texto.

## Así queda con Decorator aplicado

Mirá [`decorator.rs`](decorator.rs) de esta carpeta: en vez de un `struct`
por combinación, cada extra es un **decorador** independiente
(`MilkDecorator`, `SugarDecorator`, líneas 20 y 32) que guarda un
`beverage: Box<dyn Beverage>` — el objeto que envuelve — e implementa el
mismo trait `Beverage` (línea 5) sumándole su propia parte sobre el
resultado de delegarle la llamada.

El `main` arma la combinación "al vuelo", envolviendo un decorador dentro de
otro (líneas 45-47): `Box::new(SugarDecorator { beverage: Box::new(
MilkDecorator { beverage } ) })`. Agregar un extra de "crema" mañana es
escribir **un solo `struct` nuevo** (`CreamDecorator`), que se puede
combinar con los que ya existen en cualquier orden — nunca 16 tipos, siempre
tantos como extras tengas.
