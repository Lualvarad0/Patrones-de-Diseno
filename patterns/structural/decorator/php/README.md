# Decorator en PHP

## El problema, en código

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción. El primer instinto es
resolverlo con herencia, una subclase por combinación:

```php
class Coffee
{
    public function description(): string { return "Coffee"; }
    public function cost(): float { return 2.0; }
}

class CoffeeWithMilk extends Coffee
{
    public function description(): string { return "Coffee + Milk"; }
    public function cost(): float { return 2.5; }
}

class CoffeeWithSugar extends Coffee
{
    public function description(): string { return "Coffee + Sugar"; }
    public function cost(): float { return 2.2; }
}

class CoffeeWithMilkAndSugar extends Coffee
{
    public function description(): string { return "Coffee + Milk + Sugar"; }
    public function cost(): float { return 2.7; }
}
// y cuando el negocio pide sumar "crema" como quinto extra, cada
// combinación existente se duplica: CoffeeWithCrema, CoffeeWithMilkAndCrema...
```

Con solo 2 extras ya tenés 4 clases. Con 4 extras (leche, azúcar, crema,
shot extra) son 16 combinaciones posibles, y agregar un quinto extra
(canela) duplica otra vez la cantidad de clases que tendrías que escribir y
mantener — aunque la única diferencia real entre ellas sea sumar un precio y
concatenar un texto.

## Así queda con Decorator aplicado

Mirá [`Decorator.php`](Decorator.php) de esta carpeta: en vez de una
subclase por combinación, cada extra es un **decorador** independiente
(`MilkDecorator`, `SugarDecorator`, líneas 25 y 31) que extiende
`BeverageDecorator` (línea 17), la cual guarda en una propiedad promovida
(`protected Beverage $beverage`, línea 19) el objeto que envuelve, para
poder sumarle su parte encima.

El bloque de demo arma la combinación "al vuelo", envolviendo un decorador
dentro de otro (líneas 38-40): `new SugarDecorator(new MilkDecorator(new
SimpleCoffee()))`. Agregar un extra de "crema" mañana es escribir **una sola
clase nueva** (`CreamDecorator`), que se puede combinar con las que ya
existen en cualquier orden — nunca 16 clases, siempre tantas clases como
extras tengas.
