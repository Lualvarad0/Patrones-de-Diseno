# Flyweight en C#

## El problema, en código

Tu juego dibuja un bosque de un millón de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Sin Flyweight, cada `Tree` guarda su
propia copia del nombre y el sprite:

```csharp
public class Tree
{
    private readonly int _x, _y;
    private readonly string _name;   // "Pine" repetido 500,000 veces
    private readonly string _sprite; // el sprite completo, repetido otras 500,000 veces

    public Tree(int x, int y, string name, string sprite)
    {
        _x = x; _y = y; _name = name; _sprite = sprite;
    }
}
// un millón de árboles = un millón de copias del nombre y el sprite,
// aunque solo haya 2 o 3 especies distintas de verdad
```

Si el sprite pesa unos cuantos KB, un millón de copias idénticas se come la
memoria por nada — los datos son los mismos, solo cambia la posición de
cada árbol.

## Así queda con Flyweight aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `TreeType` (línea 5)
guarda el nombre y el sprite — el estado pesado y repetido (intrínseco).
`TreeFactory.GetTreeType()` (línea 25) devuelve siempre la misma instancia
de `TreeType` para un mismo nombre, creándola una sola vez (línea 27-32).
`Tree` (línea 39) ya no guarda nombre ni sprite: solo su posición (`_x`,
`_y`) y una referencia compartida a `TreeType` (línea 42) — el estado que
sí varía por instancia (extrínseco).

El `Main` (línea 56) pide dos árboles "Pine" y uno "Oak": el factory crea
`TreeType` solo dos veces (una por especie), sin importar cuántos árboles
"Pine" termine habiendo en el bosque (línea 62, comentario "reuses the
same TreeType").
