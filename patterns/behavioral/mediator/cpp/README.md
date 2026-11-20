# Mediator en C++

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` guardaría una referencia directa a todos los demás:

```cpp
class User {
    std::vector<User*> others; // a cada otro usuario, directo
public:
    void send(const std::string& message) {
        for (auto* other : others) other->receive(name, message);
    }
};
// agregar un usuario nuevo significa registrarlo en el vector "others"
// de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `User` terminaría conociendo a todos los demás usuarios
directamente; agregar a Dave al chat significaría ir y modificar a
Alice, Bob y Carol para que también lo conozcan a él.

## Así queda con Mediator aplicado

Mirá [`mediator.cpp`](mediator.cpp) de esta carpeta: `User` (línea 10) no
conoce a los demás usuarios — solo guarda una referencia a `chatRoom`
(línea 24). `ChatRoom` (línea 27) es el único que tiene la lista completa
de usuarios (`users`, línea 38) y decide a quién le llega cada mensaje:
`sendMessage()` (línea 31) recorre `users` y le entrega el mensaje a
todos salvo al que lo envió (línea 33).

El `main` (línea 49) crea tres usuarios pasándoles el mismo `chatRoom`
(líneas 51-53); cada `User` se registra solo en su constructor (línea
42, `chatRoom.registerUser(this)`). Cuando Alice llama `send()` (línea
55), ni ella ni el código que la creó necesitan saber que Bob y Carol
existen — agregar un cuarto usuario es una línea más en `main`, cero
cambios en `User`.
