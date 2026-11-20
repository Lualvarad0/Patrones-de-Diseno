# Strategy en Rust

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `match`:

```rust
struct ShoppingCart;

impl ShoppingCart {
    fn checkout(&self, amount: f64, method: &str) {
        match method {
            "credit_card" => {
                // 20 líneas validando el número de tarjeta, llamando al banco...
                println!("Paid ${amount} with credit card");
            }
            "paypal" => {
                // 15 líneas armando el request a la API de PayPal...
                println!("Paid ${amount} with PayPal");
            }
            // y ahora piden sumar crypto, y después transferencia bancaria...
            _ => {}
        }
    }
}
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo `checkout()` y agregarle un brazo más al `match`.
Con 5 o 6 métodos de pago, la función ya tiene cientos de líneas, cualquier
cambio en la lógica de PayPal arriesga romper por error la de tarjeta de
crédito (están en el mismo bloque de código), y para probar solo PayPal con
un test unitario tenés que ejecutar igual toda la función con todas sus
ramas.

## Así queda con Strategy aplicado

Mirá [`strategy.rs`](strategy.rs) de esta carpeta: `checkout()` (línea 35)
ya no sabe nada de tarjetas ni de PayPal — solo tiene un
`Box<dyn PaymentStrategy>` (línea 25) y le delega el cobro con
`self.payment_strategy.pay(amount)`. Cada forma de pago es un `struct`
separado e independiente (`CreditCardPayment`, `PayPalPayment`, líneas 7 y
14) que implementa el trait `PaymentStrategy`. El `Box<dyn ...>` es lo que
permite que `ShoppingCart` guarde "cualquier cosa que implemente este
trait" sin saber de antemano cuál — es el equivalente en Rust a una
interfaz con despacho dinámico. Agregar `CryptoPayment` mañana es escribir
un `struct` nuevo — `ShoppingCart` no se toca.

El `main` incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `set_payment_strategy`, con `PayPalPayment` — sin
ningún `match` de por medio.
