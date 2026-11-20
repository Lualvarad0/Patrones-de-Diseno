# Chain of Responsibility en PHP

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, una sola función concentra
todas las reglas de escalamiento:

```php
function handleTicket(int $severity): void {
    if ($severity <= 1) echo "Level1 resolved severity {$severity}\n";
    elseif ($severity <= 2) echo "Level2 resolved severity {$severity}\n";
    elseif ($severity <= 3) echo "Level3 resolved severity {$severity}\n";
    else echo "No handler could resolve severity {$severity}\n";
    // agregar un Level4 significa editar esta función y
    // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Esta función tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`ChainOfResponsibility.php`](ChainOfResponsibility.php) de esta
carpeta: `SupportHandler` (línea 5) define `handle()` (línea 15) una sola
vez — si `canHandle()` (línea 26) es verdadero, resuelve; si no, delega en
`$this->next` (línea 20). Cada nivel (`Level1Support`, línea 30;
`Level2Support`, línea 36; `Level3Support`, línea 42) solo implementa su
propio umbral, sin saber nada de los demás niveles.

El bloque de demo (línea 49) arma la cadena con `setNext()` (línea 52):
`$level1->setNext($level2)->setNext($level3)`. Después solo llama
`$level1->handle($severity)` (líneas 54-57); cada handler decide solo si
le toca a él o lo pasa al siguiente. Agregar un `Level4Support` es una
clase nueva y una línea en la cadena — cero cambios en `handle()`.
