# Strategy en Java

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `if`:

```java
public class ShoppingCart {
    public void checkout(double amount, String method) {
        if (method.equals("credit_card")) {
            // 20 líneas validando el número de tarjeta, llamando al banco...
            System.out.println("Paid $" + amount + " with credit card");
        } else if (method.equals("paypal")) {
            // 15 líneas armando el request a la API de PayPal...
            System.out.println("Paid $" + amount + " with PayPal");
        }
        // y ahora piden sumar crypto, y después transferencia bancaria...
    }
}
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo `checkout()` y agregarle un `else if` más. Con 5 o
6 métodos de pago, la función ya tiene cientos de líneas, cualquier cambio
en la lógica de PayPal arriesga romper por error la de tarjeta de crédito
(están en el mismo bloque de código), y para probar solo PayPal con un test
unitario tenés que ejecutar igual toda la función con todas sus ramas.

## Así queda con Strategy aplicado

Mirá [`StrategyDemo.java`](StrategyDemo.java) de esta carpeta: `checkout()`
(línea 25) ya no sabe nada de tarjetas ni de PayPal — solo tiene una
referencia a `PaymentStrategy` (línea 19) y le delega el cobro con
`paymentStrategy.pay(amount)`. Cada forma de pago es una clase separada e
independiente (`CreditCardPayment`, `PayPalPayment`, líneas 8 y 12) que
implementa esa misma interfaz. Agregar `CryptoPayment` mañana es escribir
una clase nueva — `ShoppingCart` no se toca ni se recompila.

El `main` incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `setPaymentStrategy`, con `PayPalPayment` — sin ningún
`if` de por medio.
