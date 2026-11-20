# Flyweight en Java

## El problema, en código

Tu juego dibuja un bosque de un millón de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Sin Flyweight, cada `Tree` guarda su
propia copia del nombre y el sprite:

```java
class Tree {
    private final int x, y;
    private final String name;   // "Pine" repetido 500,000 veces
    private final String sprite; // el sprite completo, repetido otras 500,000 veces

    Tree(int x, int y, String name, String sprite) {
        this.x = x; this.y = y; this.name = name; this.sprite = sprite;
    }
}
// un millón de árboles = un millón de copias del nombre y el sprite,
// aunque solo haya 2 o 3 especies distintas de verdad
```

Si el sprite pesa unos cuantos KB, un millón de copias idénticas se come la
memoria por nada — los datos son los mismos, solo cambia la posición de
cada árbol.

## Así queda con Flyweight aplicado

Mirá [`FlyweightDemo.java`](FlyweightDemo.java) de esta carpeta: `TreeType`
(línea 10) guarda el nombre y el sprite — el estado pesado y repetido
(intrínseco). `TreeFactory.getTreeType()` (línea 29) devuelve siempre la
misma instancia de `TreeType` para un mismo nombre, creándola una sola vez
(líneas 30-35). `Tree` (línea 42) ya no guarda nombre ni sprite: solo su
posición (`x`, `y`) y una referencia compartida a `TreeType` (línea 44) —
el estado que sí varía por instancia (extrínseco).

El `main` (línea 58) pide dos árboles "Pine" y uno "Oak": el factory crea
`TreeType` solo dos veces (una por especie), sin importar cuántos árboles
"Pine" termine habiendo en el bosque (línea 62, comentario "reuses the
same TreeType").
