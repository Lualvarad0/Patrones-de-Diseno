# Singleton en C#

## El problema, en código

Imaginá que `Logger` es una clase común, con constructor público, y que el
backend de una tienda online tiene varios módulos que necesitan loguear:

```csharp
public class Logger
{
    private int _messageCount = 0;
    public void Log(string message)
    {
        _messageCount++;
        Console.WriteLine($"[{_messageCount}] {message}");
    }
}

public class PaymentService
{
    private Logger _logger = new Logger(); // crea SU PROPIA instancia
    public void Charge(double amount) => _logger.Log($"Charged ${amount}");
}

public class InventoryService
{
    private Logger _logger = new Logger(); // y esta es OTRA instancia distinta
    public void Restock(int qty) => _logger.Log($"Restocked {qty} units");
}
```

Cada servicio tiene su propio `_messageCount`, así que el número entre
corchetes de cada línea de log arranca de cero en cada módulo — perdés la
idea de "mensaje #47 de la app" y pasás a tener tres contadores que no
significan nada en conjunto. Si `Logger` en vez de `Console.WriteLine`
escribiera a un archivo (`File.AppendAllText`), cada instancia abriría su
propio handle al mismo archivo, y vas a terminar con líneas intercaladas o
truncadas cuando dos módulos loguean casi al mismo tiempo.

## Así queda con Singleton aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: el constructor de `Logger`
es `private` (línea 12), así que `new Logger()` directamente **no compila**
fuera de la propia clase. La única puerta de entrada es la propiedad
estática `Instance` (línea 8), respaldada por un `Lazy<Logger>` que crea el
objeto una sola vez, la primera vez que alguien lo pide, y lo reutiliza
siempre después (sin necesidad de locks manuales, porque `Lazy<T>` ya es
thread-safe).

Con esto, `PaymentService` e `InventoryService` del ejemplo de arriba
pasarían a escribir `Logger.Instance.Log(...)` en vez de crear su propio
`Logger`, y los dos terminarían compartiendo el mismo `_messageCount` y el
mismo archivo/conexión de salida — exactamente lo que el demo del `Program`
verifica al comparar `ReferenceEquals(Logger.Instance, sameLogger)`.
