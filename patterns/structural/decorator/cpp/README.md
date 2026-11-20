# Decorator en C++

## El problema, en código

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción. El primer instinto es
resolverlo con herencia, una subclase por combinación:

```cpp
class Coffee {
public:
    virtual std::string description() const { return "Coffee"; }
    virtual double cost() const { return 2.0; }
};

class CoffeeWithMilk : public Coffee {
public:
    std::string description() const override { return "Coffee + Milk"; }
    double cost() const override { return 2.5; }
};

class CoffeeWithSugar : public Coffee {
public:
    std::string description() const override { return "Coffee + Sugar"; }
    double cost() const override { return 2.2; }
};

class CoffeeWithMilkAndSugar : public Coffee {
public:
    std::string description() const override { return "Coffee + Milk + Sugar"; }
    double cost() const override { return 2.7; }
};
// y cuando el negocio pide sumar "crema" como quinto extra, cada
// combinación existente se duplica: CoffeeWithCrema, CoffeeWithMilkAndCrema...
```

Con solo 2 extras ya tenés 4 clases. Con 4 extras (leche, azúcar, crema,
shot extra) son 16 combinaciones posibles, y agregar un quinto extra
(canela) duplica otra vez la cantidad de clases que tendrías que escribir y
mantener — aunque la única diferencia real entre ellas sea sumar un precio y
concatenar un texto.

## Así queda con Decorator aplicado

Mirá [`decorator.cpp`](decorator.cpp) de esta carpeta: en vez de una
subclase por combinación, cada extra es un **decorador** independiente
(`MilkDecorator`, `SugarDecorator`, líneas 30 y 39) que hereda de
`BeverageDecorator` (línea 21), la cual guarda un
`std::unique_ptr<Beverage>` al objeto que envuelve para poder sumarle su
parte encima.

El `main` arma la combinación "al vuelo", envolviendo un decorador dentro de
otro (líneas 49-51): `std::make_unique<SugarDecorator>(std::make_unique<
MilkDecorator>(std::move(beverage)))`. Agregar un extra de "crema" mañana es
escribir **una sola clase nueva** (`CreamDecorator`), que se puede combinar
con las que ya existen en cualquier orden — nunca 16 clases, siempre tantas
clases como extras tengas.
