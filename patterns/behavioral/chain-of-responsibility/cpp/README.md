# Chain of Responsibility en C++

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, una sola función concentra
todas las reglas de escalamiento:

```cpp
void handleTicket(int severity) {
    if (severity <= 1) std::cout << "Level1 resolved severity " << severity << std::endl;
    else if (severity <= 2) std::cout << "Level2 resolved severity " << severity << std::endl;
    else if (severity <= 3) std::cout << "Level3 resolved severity " << severity << std::endl;
    else std::cout << "No handler could resolve severity " << severity << std::endl;
    // agregar un Level4 significa editar esta función y
    // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Esta función tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`chain_of_responsibility.cpp`](chain_of_responsibility.cpp) de esta
carpeta: `SupportHandler` (línea 7) define `handle()` (línea 14) una sola
vez — si `canHandle()` (línea 27) es verdadero, resuelve; si no, delega en
`next` (línea 18). Cada nivel (`Level1Support`, línea 34; `Level2Support`,
línea 40; `Level3Support`, línea 46) solo implementa su propio umbral, sin
saber nada de los demás niveles.

El `main` (línea 52) arma la cadena con `setNext()` (línea 9), que
devuelve un puntero crudo al handler recién agregado para poder seguir
encadenando (líneas 53-55). Después solo llama `level1->handle(severity)`
(líneas 57-60); cada handler decide solo si le toca a él o lo pasa al
siguiente. Agregar un `Level4Support` es una clase nueva y una línea en la
cadena — cero cambios en `handle()`.
