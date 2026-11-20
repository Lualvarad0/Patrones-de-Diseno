# Chain of Responsibility en C#

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, una sola función concentra
todas las reglas de escalamiento:

```csharp
void HandleTicket(int severity)
{
    if (severity <= 1) Console.WriteLine("Level1 resolved severity " + severity);
    else if (severity <= 2) Console.WriteLine("Level2 resolved severity " + severity);
    else if (severity <= 3) Console.WriteLine("Level3 resolved severity " + severity);
    else Console.WriteLine("No handler could resolve severity " + severity);
    // agregar un Level4 significa editar esta función y
    // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Esta función tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `SupportHandler` (línea
4) define `Handle()` (línea 14) una sola vez — si `CanHandle()` (línea 30)
es verdadero, resuelve; si no, delega en `_next` (línea 22). Cada nivel
(`Level1Support`, línea 34; `Level2Support`, línea 40; `Level3Support`,
línea 46) solo implementa su propio umbral, sin saber nada de los demás
niveles.

El `Main` (línea 54) arma la cadena con `SetNext()` (línea 59):
`level1.SetNext(level2).SetNext(level3)`. Después solo llama
`level1.Handle(severity)` (líneas 61-64); cada handler decide solo si le
toca a él o lo pasa al siguiente. Agregar un `Level4Support` es una clase
nueva y una línea en la cadena — cero cambios en `Handle()`.
