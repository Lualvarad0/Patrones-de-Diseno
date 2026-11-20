# Strategy en PHP

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `if`:

```php
class ShoppingCart
{
    public function checkout(float $amount, string $method): void
    {
        if ($method === 'credit_card') {
            // 20 líneas validando el número de tarjeta, llamando al banco...
            echo "Paid \${$amount} with credit card\n";
        } elseif ($method === 'paypal') {
            // 15 líneas armando el request a la API de PayPal...
            echo "Paid \${$amount} with PayPal\n";
        }
        // y ahora piden sumar crypto, y después transferencia bancaria...
    }
}
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo `checkout()` y agregarle un `elseif` más. Con 5 o
6 métodos de pago, la función ya tiene cientos de líneas, cualquier cambio
en la lógica de PayPal arriesga romper por error la de tarjeta de crédito
(están en el mismo bloque de código), y para probar solo PayPal con un test
unitario tenés que ejecutar igual toda la función con todas sus ramas.

## Así queda con Strategy aplicado

Mirá [`Strategy.php`](Strategy.php) de esta carpeta: `checkout()` (línea 33)
ya no sabe nada de tarjetas ni de PayPal — solo tiene una propiedad
`$paymentStrategy` tipada con la interfaz `PaymentStrategy` (línea 29) y le
delega el cobro con `$this->paymentStrategy->pay($amount)`. Cada forma de
pago es una clase separada e independiente (`CreditCardPayment`,
`PayPalPayment`, líneas 9 y 15) que implementa esa interfaz. Agregar
`CryptoPayment` mañana es escribir una clase nueva — `ShoppingCart` no se
toca.

El bloque de demo incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `setPaymentStrategy`, con `PayPalPayment` — sin ningún
`if` de por medio.
