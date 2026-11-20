# Mediator en C#

## El problema, en código

Tu chat deja que varios usuarios se escriban entre sí. Sin Mediator, cada
`User` guarda una referencia directa a todos los demás:

```csharp
public class User
{
    private readonly List<User> _others = new(); // a cada otro usuario, directo

    public void Send(string message)
    {
        foreach (var other in _others)
            other.Receive(this.Name, message);
    }
}
// agregar un usuario nuevo significa registrarlo en la lista _others
// de TODOS los usuarios existentes — conexiones que crecen como N²
```

Cada `User` termina conociendo a todos los demás usuarios directamente;
agregar a Dave al chat significa ir y modificar a Alice, Bob y Carol para
que también lo conozcan a él.

## Así queda con Mediator aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `User` (línea 19) no
conoce a los demás usuarios — solo conoce a `_chatRoom` (línea 22).
`ChatRoom` (línea 4) es el único que tiene la lista completa de usuarios
(`_users`, línea 6) y decide a quién le llega cada mensaje:
`SendMessage()` (línea 10) recorre `_users` y le entrega el mensaje a
todos salvo al que lo envió (línea 14).

El `Main` (línea 38) crea tres usuarios pasándoles el mismo `chatRoom`
(líneas 41-43); cada `User` se registra solo (línea 28,
`chatRoom.Register(this)`). Cuando Alice llama `Send()` (línea 45), ni
ella ni el código que la creó necesitan saber que Bob y Carol existen —
agregar un cuarto usuario es una línea más en `Main`, cero cambios en
`User`.
