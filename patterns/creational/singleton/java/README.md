# Singleton en Java

## El problema, en código

Imaginá una clase `Logger` común, con constructor público, usada por varios
servicios del backend de una tienda online:

```java
public class Logger {
    private int messageCount = 0;
    public void log(String message) {
        messageCount++;
        System.out.println("[" + messageCount + "] " + message);
    }
}

public class PaymentService {
    private Logger logger = new Logger(); // crea SU PROPIA instancia
    public void charge(double amount) { logger.log("Charged $" + amount); }
}

public class InventoryService {
    private Logger logger = new Logger(); // y esta es OTRA instancia distinta
    public void restock(int qty) { logger.log("Restocked " + qty + " units"); }
}
```

Cada servicio tiene su propio `messageCount`, así que el número entre
corchetes arranca de cero en cada módulo en vez de representar "mensaje #N
de toda la app". Si `Logger` escribiera a un archivo con un
`FileWriter` propio en vez de `System.out`, cada instancia abriría su
propio file handle al mismo archivo — con el sistema operativo entregando
turnos de escritura, eso termina en líneas de log cortadas o pisadas entre
sí cuando dos servicios loguean casi al mismo tiempo.

## Así queda con Singleton aplicado

Mirá [`Logger.java`](Logger.java) de esta carpeta: el constructor es
`private` (línea 10), así que `new Logger()` fuera de la propia clase
directamente **no compila**. La única puerta de entrada es
`Logger.getInstance()` (línea 12), que devuelve la constante estática
`INSTANCE` creada una sola vez cuando la JVM carga la clase — la propia JVM
garantiza que esa inicialización sea segura entre hilos, sin que tengas que
sincronizar nada vos mismo.

Con esto, `PaymentService` e `InventoryService` del ejemplo de arriba
pasarían a usar `Logger.getInstance().log(...)` en vez de `new Logger()`, y
los dos compartirían el mismo `messageCount` y la misma salida — exactamente
lo que el `main` de este archivo verifica comparando
`Logger.getInstance() == sameLogger`.
