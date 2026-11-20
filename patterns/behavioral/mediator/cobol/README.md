# Mediator en COBOL

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`user` guardaría una referencia directa a todos los demás:

```cobol
*> cada "user" con su propia tabla de referencias a los demás usuarios
01 other-users.
    05 other-entry object reference occurs 10 times.
*> agregar un usuario nuevo significa registrarlo en la other-users
*> de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `user` terminaría conociendo a todos los demás usuarios
directamente; agregar a Dave al chat significaría ir y modificar la
tabla de referencias de Alice, Bob y Carol.

## Así queda con Mediator aplicado

Mirá [`mediator.cbl`](mediator.cbl) de esta carpeta: `user` (línea 46) no
conoce a los demás usuarios — solo guarda una referencia a
`the-chatroom` (línea 56). `chat-room` (línea 7) es el único que tiene la
lista completa de usuarios (`user-table`, línea 12) y decide a quién le
llega cada mensaje: `send-message` (línea 26) recorre `user-table` y le
entrega el mensaje a todos salvo al que coincide con `sender` (líneas
34-38).

El párrafo principal (línea 110) crea tres usuarios pasándoles el mismo
`chat-room-obj` (líneas 113-120); cada `user` se registra solo en `init`
(línea 67, `invoke the-chatroom "register" using self`). Cuando Alice
invoca `"send"` (línea 122), ni ella ni el párrafo principal necesitan
saber que Bob y Carol existen — agregar un cuarto usuario es una
invocación más de `"new"`/`"init"`, cero cambios en la clase `user`.
