# Flyweight en C++

## El problema, en código

Tu juego dibuja un bosque de un millón de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Sin Flyweight, cada `Tree` guarda su
propia copia del nombre y el sprite:

```cpp
class Tree {
public:
    Tree(int x, int y, std::string name, std::string sprite)
        : x(x), y(y), name(std::move(name)), sprite(std::move(sprite)) {}

private:
    int x, y;
    std::string name;   // "Pine" repetido 500,000 veces
    std::string sprite; // el sprite completo, repetido otras 500,000 veces
};
// un millón de árboles = un millón de copias del nombre y el sprite,
// aunque solo haya 2 o 3 especies distintas de verdad
```

Si el sprite pesa unos cuantos KB, un millón de copias idénticas se come la
memoria por nada — los datos son los mismos, solo cambia la posición de
cada árbol.

## Así queda con Flyweight aplicado

Mirá [`flyweight.cpp`](flyweight.cpp) de esta carpeta: `TreeType` (línea
12) guarda el nombre y el sprite — el estado pesado y repetido
(intrínseco). `TreeFactory::getTreeType()` (línea 29) devuelve siempre el
mismo `shared_ptr<TreeType>` para un mismo nombre: si ya existe, lo
devuelve directo (línea 31); si no, lo crea una vez con
`make_shared` (líneas 33-36). `Tree` (línea 45) ya no guarda nombre ni
sprite: solo su posición (`x`, `y`) y un `shared_ptr<TreeType>` compartido
(línea 53) — el estado que sí varía por instancia (extrínseco).

El `main` (línea 56) pide dos árboles "Pine" y uno "Oak": el factory crea
`TreeType` solo dos veces (una por especie); el segundo "Pine" (línea 60)
solo copia el `shared_ptr` existente, sin imprimir "Created new
TreeType".
