# Chain of Responsibility en Java

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, un solo método concentra todas
las reglas de escalamiento:

```java
void handleTicket(int severity) {
    if (severity <= 1) System.out.println("Level1 resolved severity " + severity);
    else if (severity <= 2) System.out.println("Level2 resolved severity " + severity);
    else if (severity <= 3) System.out.println("Level3 resolved severity " + severity);
    else System.out.println("No handler could resolve severity " + severity);
    // agregar un Level4 significa editar este método y
    // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Este método tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`ChainOfResponsibilityDemo.java`](ChainOfResponsibilityDemo.java) de
esta carpeta: `SupportHandler` (línea 4) define `handle()` (línea 12) una
sola vez — si `canHandle()` (línea 22) es verdadero, resuelve; si no,
delega en `next` (línea 16). Cada nivel (`Level1Support`, línea 26;
`Level2Support`, línea 31; `Level3Support`, línea 36) solo implementa su
propio umbral, sin saber nada de los demás niveles.

El `main` (línea 42) arma la cadena con `setNext()` (línea 46):
`level1.setNext(level2).setNext(level3)`. Después solo llama
`level1.handle(severity)` (líneas 48-51); cada handler decide solo si le
toca a él o lo pasa al siguiente. Agregar un `Level4Support` es una clase
nueva y una línea en la cadena — cero cambios en `handle()`.
