# Strategy en C++

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `if`:

```cpp
class ShoppingCart {
public:
    void checkout(double amount, const std::string& method) {
        if (method == "credit_card") {
            // 20 líneas validando el número de tarjeta, llamando al banco...
            std::cout << "Paid $" << amount << " with credit card" << std::endl;
        } else if (method == "paypal") {
            // 15 líneas armando el request a la API de PayPal...
            std::cout << "Paid $" << amount << " with PayPal" << std::endl;
        }
        // y ahora piden sumar crypto, y después transferencia bancaria...
    }
};
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo `checkout()` y agregarle un `else if` más. Con 5 o
6 métodos de pago, la función ya tiene cientos de líneas, cualquier cambio
en la lógica de PayPal arriesga romper por error la de tarjeta de crédito
(están en el mismo bloque de código), y para probar solo PayPal con un test
unitario tenés que ejecutar igual toda la función con todas sus ramas.

## Así queda con Strategy aplicado

Mirá [`strategy.cpp`](strategy.cpp) de esta carpeta: `checkout()` (línea 42)
ya no sabe nada de tarjetas ni de PayPal — solo tiene un
`std::unique_ptr<PaymentStrategy>` (línea 46) y le delega el cobro con
`paymentStrategy->pay(amount)`. Cada forma de pago es una clase separada e
independiente (`CreditCardPayment`, `PayPalPayment`, líneas 13 y 19) que
hereda de la clase abstracta `PaymentStrategy` (línea 7) y sobrescribe su
método virtual puro `pay()`. Agregar `CryptoPayment` mañana es escribir una
clase nueva — `ShoppingCart` no se toca ni se recompila.

El `main` incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `setPaymentStrategy`, con `PayPalPayment` — sin ningún
`if` de por medio.
