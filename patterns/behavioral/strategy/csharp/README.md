# Strategy en C#

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de `Checkout()`. Cuando el negocio pidió sumar PayPal, lo más rápido
fue agregar un `if`:

```csharp
public class ShoppingCart
{
    public void Checkout(double amount, string method)
    {
        if (method == "credit_card")
        {
            // 20 líneas validando el número de tarjeta, llamando al banco...
            Console.WriteLine($"Paid ${amount} with credit card");
        }
        else if (method == "paypal")
        {
            // 15 líneas armando el request a la API de PayPal...
            Console.WriteLine($"Paid ${amount} with PayPal");
        }
        // y ahora piden sumar crypto, y después transferencia bancaria...
    }
}
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo `Checkout()` y agregarle un `else if` más. Con 5
o 6 métodos de pago, la función ya tiene cientos de líneas, cualquier cambio
en la lógica de PayPal arriesga romper por error la de tarjeta de crédito
(están en el mismo bloque de código), y para probar solo PayPal con un test
unitario tenés que ejecutar igual toda la función con todas sus ramas.

## Así queda con Strategy aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `Checkout()` (línea 29) ya
no sabe nada de tarjetas ni de PayPal — solo tiene una referencia a
`IPaymentStrategy` (línea 23) y le delega el cobro con
`_paymentStrategy.Pay(amount)`. Cada forma de pago es una clase separada e
independiente (`CreditCardPayment`, `PayPalPayment`, líneas 9 y 14) que
implementa esa misma interfaz. Agregar `CryptoPayment` mañana es escribir
una clase nueva — `ShoppingCart` no se toca ni se recompila.

El `Main` incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `CreditCardPayment` y
después, llamando a `SetPaymentStrategy`, con `PayPalPayment` — sin ningún
`if` de por medio.
