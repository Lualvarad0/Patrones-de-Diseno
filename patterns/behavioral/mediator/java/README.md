# Mediator en Java

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` guarda una referencia directa a todos los demás:

```java
class User {
    private final List<User> others = new ArrayList<>(); // a cada otro usuario, directo

    void send(String message) {
        for (User other : others) other.receive(this.name, message);
    }
}
// agregar un usuario nuevo significa registrarlo en la lista "others"
// de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `User` termina conociendo a todos los demás usuarios directamente;
agregar a Dave al chat significa ir y modificar a Alice, Bob y Carol para
que también lo conozcan a él.

## Así queda con Mediator aplicado

Mirá [`MediatorDemo.java`](MediatorDemo.java) de esta carpeta: `User`
(línea 19) no conoce a los demás usuarios — solo conoce a `chatRoom`
(línea 21). `ChatRoom` (línea 7) es el único que tiene la lista completa
de usuarios (`users`, línea 8) y decide a quién le llega cada mensaje:
`sendMessage()` (línea 12) recorre `users` y le entrega el mensaje a
todos salvo al que lo envió (línea 14).

El `main` (línea 38) crea tres usuarios pasándoles el mismo `chatRoom`
(líneas 41-43); cada `User` se registra solo (línea 26,
`chatRoom.register(this)`). Cuando Alice llama `send()` (línea 45), ni
ella ni el código que la creó necesitan saber que Bob y Carol existen —
agregar un cuarto usuario es una línea más en `main`, cero cambios en
`User`.
