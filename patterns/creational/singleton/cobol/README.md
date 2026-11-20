# Singleton en COBOL

## El problema, en código

En COBOL orientado a objetos, cualquiera puede pedir una instancia nueva de
una clase con `invoke <clase> "new"`. El error típico, entonces, es que dos
programas distintos (dos "servicios" del mismo batch) pidan cada uno la
suya:

```cobol
*> payment-service.cbl (fragmento)
01 logger-ref object reference.
invoke logger "new" returning logger-ref      *> SU PROPIA instancia
invoke logger-ref "log" using "Charge processed"

*> inventory-service.cbl (fragmento)
01 logger-ref object reference.
invoke logger "new" returning logger-ref      *> OTRA instancia distinta
invoke logger-ref "log" using "Stock updated"
```

Cada `invoke logger "new"` crea un objeto `logger` completamente nuevo, con
su propio `message-count` arrancando en cero — el programa de pagos y el de
inventario terminan cada uno con su numeración de logs independiente, sin
ninguna forma de saber cuál mensaje vino antes o después del otro en el
flujo real de la aplicación.

## Así queda con Singleton aplicado

Mirá [`singleton.cbl`](singleton.cbl) de esta carpeta: la clase `logger`
define una sección `factory` (línea 11) — en COBOL OO, la `factory` es
donde vive el almacenamiento **de la clase**, no de cada instancia, que es
exactamente donde tiene que vivir "la única instancia compartida". Dentro
de la `factory` hay un método `instance` (línea 18) que guarda la referencia
ya creada en `the-instance` y solo invoca `"new"` la primera vez que se
llama (`if the-instance = null ... end-if`, línea 19); las llamadas
siguientes devuelven esa misma referencia sin crear nada nuevo.

Con esto, los dos programas de ejemplo pasarían a pedir
`invoke logger "instance" returning logger-ref` en vez de `"new"`, y ambos
recibirían la misma referencia de objeto, compartiendo el mismo
`message-count` — igual a como el `main` de este archivo verifica que
`logger-ref` y `same-logger-ref` sean la misma referencia con `if
logger-ref = same-logger-ref`.

**Una limitación honesta:** a diferencia de C#/Java/PHP, GnuCOBOL no tiene
forma de hacer que `"new"` sea privado — nada impide, en la práctica, que
alguien siga llamando `invoke logger "new"` directamente y se salte el
Singleton. Acá el patrón depende más de la **convención del equipo** (todos
acceden por `"instance"`) que de una restricción que el compilador imponga.
