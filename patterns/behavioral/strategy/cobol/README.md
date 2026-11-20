# Strategy en COBOL

## El problema, en código

Al principio tu checkout solo aceptaba tarjeta, así que todo el cobro vivía
adentro de un solo párrafo. Cuando el negocio pidió sumar PayPal, lo más
rápido fue agregar una rama más a un `evaluate`:

```cobol
checkout.
    evaluate payment-method
        when "CREDIT_CARD"
            *> 20 líneas validando el número de tarjeta, llamando al banco...
            display "Paid $" amount " with credit card"
        when "PAYPAL"
            *> 15 líneas armando el request a la API de PayPal...
            display "Paid $" amount " with PayPal"
        *> y ahora piden sumar crypto, y después transferencia bancaria...
    end-evaluate.
```

Cada método de pago nuevo (crypto, transferencia, Mercado Pago) significa
volver a abrir este mismo párrafo `checkout` y agregarle un `when` más. Con
5 o 6 métodos de pago, el párrafo ya tiene cientos de líneas, cualquier
cambio en la lógica de PayPal arriesga romper por error la de tarjeta de
crédito (están en el mismo bloque de código), y no hay forma de probar la
lógica de un solo método de pago sin ejecutar todo el `evaluate`.

## Así queda con Strategy aplicado

Mirá [`strategy.cbl`](strategy.cbl) de esta carpeta: la clase
`shopping-cart` (línea 36) ya no sabe nada de tarjetas ni de PayPal — guarda
una referencia genérica a objeto en `payment-strategy` (línea 39) y el
método `checkout` (línea 48) le delega el cobro con
`invoke payment-strategy "pay" using amount`. Cada forma de pago es una
clase COBOL separada e independiente (`credit-card-payment`,
`paypal-payment`, líneas 7 y 21) que expone el mismo método `pay` — como
COBOL OO no obliga a declarar una interfaz formal, alcanza con que el
objeto tenga ese método (el mismo "duck typing" dinámico que usa
`invoke`). Agregar `crypto-payment` mañana es escribir una clase nueva —
`shopping-cart` no se toca.

El `main` incluso muestra el cambio de estrategia **en tiempo de
ejecución**: el mismo carrito cobra primero con `credit-card-payment` y
después, llamando a `set-payment-strategy`, con `paypal-payment` — sin
ningún `evaluate` de por medio.
