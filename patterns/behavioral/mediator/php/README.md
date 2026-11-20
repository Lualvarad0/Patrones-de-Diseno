# Mediator en PHP

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` guarda una referencia directa a todos los demás:

```php
class User
{
    private array $others = []; // a cada otro usuario, directo

    public function send(string $message): void
    {
        foreach ($this->others as $other) $other->receive($this->name, $message);
    }
}
// agregar un usuario nuevo significa registrarlo en $others
// de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `User` termina conociendo a todos los demás usuarios directamente;
agregar a Dave al chat significa ir y modificar a Alice, Bob y Carol para
que también lo conozcan a él.

## Así queda con Mediator aplicado

Mirá [`Mediator.php`](Mediator.php) de esta carpeta: `User` (línea 25) no
conoce a los demás usuarios — solo conoce a `$chatRoom` (línea 27).
`ChatRoom` (línea 5) es el único que tiene la lista completa de usuarios
(`$users`, línea 8) y decide a quién le llega cada mensaje:
`sendMessage()` (línea 15) recorre `$users` y le entrega el mensaje a
todos salvo al que lo envió (línea 18).

El bloque de demo (línea 45) crea tres usuarios pasándoles el mismo
`$chatRoom` (líneas 47-49); cada `User` se registra solo en su
constructor (línea 29, `$chatRoom->register($this)`). Cuando Alice llama
`send()` (línea 51), ni ella ni el código que la creó necesitan saber que
Bob y Carol existen — agregar un cuarto usuario es una línea más en la
demo, cero cambios en `User`.
