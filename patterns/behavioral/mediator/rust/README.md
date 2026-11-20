# Mediator en Rust

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` necesitaría una referencia directa a todos los demás:

```rust
struct User {
    name: String,
    others: Vec<Rc<User>>, // a cada otro usuario, directo
}
// agregar un usuario nuevo significa registrarlo en el Vec "others"
// de TODOS los usuarios existentes — conexiones que crecen como N²,
// y en Rust además te obliga a lidiar con referencias compartidas
// mutables entre todos esos usuarios (Rc<RefCell<...>> por todos lados)
```

Cada `User` terminaría conociendo a todos los demás directamente, con la
complicación extra de que las referencias cruzadas en Rust requieren
`Rc`/`RefCell` en cada punta; agregar a Dave al chat significaría ir y
modificar la lista de Alice, Bob y Carol.

## Así queda con Mediator aplicado

Mirá [`mediator.rs`](mediator.rs) de esta carpeta: `User` (línea 10) no
guarda ninguna referencia a otros usuarios ni al mediador — solo tiene su
`name` y sabe `receive()` un mensaje (línea 15). `ChatRoom` (línea 20) es
dueño de todos los `User` (`users: Vec<User>`, línea 21) y decide a quién
le llega cada mensaje: `send_message()` (línea 33) recorre `users` y le
entrega el mensaje a todos salvo al que coincide con `sender_name`
(líneas 34-38).

El `main` (línea 42) registra tres usuarios con `register()` (líneas
44-46) y para enviar un mensaje llama directamente
`chat_room.send_message("Alice", "Hey everyone!")` (línea 48) — ni
siquiera hace falta un objeto `User` separado del lado del llamador,
porque el dueño real de todos los usuarios es el mediador. Agregar un
cuarto usuario es una línea más de `register()` — cero cambios en
`User`.
