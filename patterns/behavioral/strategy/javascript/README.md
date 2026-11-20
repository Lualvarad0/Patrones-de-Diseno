# Strategy en JavaScript

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `if`:

```js
class ShoppingCart {
  checkout(amount, method) {
    if (method === "credit_card") {
      // 20 líneas validando el número de tarjeta, llamando al banco...
      console.log(`Paid $${amount} with credit card`);
    } else if (method === "paypal") {
      // 15 líneas armando el request a la API de PayPal...
      console.log(`Paid $${amount} with PayPal`);
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

Mirá [`strategy.js`](strategy.js) de esta carpeta: `checkout()` (línea 28)
ya no sabe nada de tarjetas ni de PayPal — solo tiene una referencia
guardada en `this.paymentStrategy` (línea 19) y le delega el cobro con
`this.paymentStrategy.pay(amount)`. Cada forma de pago es una clase
separada e independiente (`CreditCardPayment`, `PayPalPayment`, líneas 5 y
10) que expone el mismo método `pay()` — en JavaScript no hace falta ni una
interfaz explícita, alcanza con que el objeto tenga ese método (duck
typing). Agregar `CryptoPayment` mañana es escribir una clase nueva —
`ShoppingCart` no se toca.

El bloque de demo incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `setPaymentStrategy`, con `PayPalPayment` — sin ningún
`if` de por medio.
