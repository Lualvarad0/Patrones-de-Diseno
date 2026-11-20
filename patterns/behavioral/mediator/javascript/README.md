# Mediator en JavaScript

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` guarda una referencia directa a todos los demás:

```javascript
class User {
  others = []; // a cada otro usuario, directo

  send(message) {
    for (const other of this.others) other.receive(this.name, message);
  }
}
// agregar un usuario nuevo significa registrarlo en el arreglo "others"
// de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `User` termina conociendo a todos los demás usuarios directamente;
agregar a Dave al chat significa ir y modificar a Alice, Bob y Carol para
que también lo conozcan a él.

## Así queda con Mediator aplicado

Mirá [`mediator.js`](mediator.js) de esta carpeta: `User` (línea 18) no
conoce a los demás usuarios — solo conoce a `this.chatRoom` (línea 21).
`ChatRoom` (línea 4) es el único que tiene la lista completa de usuarios
(`#users`, línea 5) y decide a quién le llega cada mensaje:
`sendMessage()` (línea 11) recorre `#users` y le entrega el mensaje a
todos salvo al que lo envió (línea 13).

El bloque de demo (línea 34) crea tres usuarios pasándoles el mismo
`chatRoom` (líneas 36-38); cada `User` se registra solo (línea 22,
`chatRoom.register(this)`). Cuando Alice llama `send()` (línea 40), ni
ella ni el código que la creó necesitan saber que Bob y Carol existen —
agregar un cuarto usuario es una línea más en la demo, cero cambios en
`User`.
