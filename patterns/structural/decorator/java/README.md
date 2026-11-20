# Decorator en Java

## El problema, en código

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción. El primer instinto es
resolverlo con herencia, una subclase por combinación:

```java
class Coffee {
    String description() { return "Coffee"; }
    double cost() { return 2.0; }
}

class CoffeeWithMilk extends Coffee {
    String description() { return "Coffee + Milk"; }
    double cost() { return 2.5; }
}

class CoffeeWithSugar extends Coffee {
    String description() { return "Coffee + Sugar"; }
    double cost() { return 2.2; }
}

class CoffeeWithMilkAndSugar extends Coffee {
    String description() { return "Coffee + Milk + Sugar"; }
    double cost() { return 2.7; }
}
// y cuando el negocio pide sumar "crema" como quinto extra, cada
// combinación existente se duplica: CoffeeWithCrema, CoffeeWithMilkAndCrema,
// CoffeeWithSugarAndCrema, CoffeeWithMilkSugarAndCrema...
```

Con solo 2 extras ya tenés 4 clases. Con 4 extras (leche, azúcar, crema,
shot extra) son 16 combinaciones posibles, y agregar un quinto extra
(canela) duplica otra vez la cantidad de clases que tendrías que escribir y
mantener — aunque la única diferencia real entre ellas sea sumar un precio y
concatenar un texto.

## Así queda con Decorator aplicado

Mirá [`DecoratorDemo.java`](DecoratorDemo.java) de esta carpeta: en vez de
una subclase por combinación, cada extra es un **decorador** independiente
(`MilkDecorator`, `SugarDecorator`, líneas 22 y 28) que implementa la misma
interfaz `Beverage` (línea 3) que el café base (`SimpleCoffee`, línea 7), y
que por dentro guarda una referencia al objeto que envuelve
(`BeverageDecorator`, línea 13) para poder sumarle su parte encima.

El `main` arma la combinación "al vuelo", envolviendo un decorador dentro de
otro (líneas 36-38): `new SugarDecorator(new MilkDecorator(new
SimpleCoffee()))`. Agregar un extra de "crema" mañana es escribir **una
sola clase nueva** (`CreamDecorator`), que se puede combinar con las que ya
existen en cualquier orden — nunca 16 clases, siempre tantas clases como
extras tengas.
