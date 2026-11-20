# Singleton en PHP

## El problema, en código

Imaginá una clase `Logger` común, con constructor público, usada por varios
servicios del backend de una tienda online:

```php
class Logger
{
    private int $messageCount = 0;
    public function log(string $message): void
    {
        $this->messageCount++;
        echo "[{$this->messageCount}] {$message}\n";
    }
}

class PaymentService
{
    private Logger $logger;
    public function __construct() { $this->logger = new Logger(); } // SU PROPIA instancia
}

class InventoryService
{
    private Logger $logger;
    public function __construct() { $this->logger = new Logger(); } // OTRA instancia distinta
}
```

Cada servicio tiene su propio `$messageCount`, así que el número entre
corchetes de cada log arranca de cero en cada servicio en vez de reflejar
"mensaje #N de toda la app". Y como PHP permite clonar objetos con `clone`,
también podrías terminar con una copia accidental de un `Logger` que ya
tenía estado acumulado, confundiendo más las cosas.

## Así queda con Singleton aplicado

Mirá [`Logger.php`](Logger.php) de esta carpeta: el constructor es
`private` (línea 11), así que `new Logger()` fuera de la propia clase
directamente **no compila** (PHP lo rechaza en tiempo de ejecución con un
`Error`). El método mágico `__clone()` también es `private` (línea 12), así
que `clone` tampoco puede usarse para esquivar la restricción. La única
puerta de entrada es el método estático `Logger::getInstance()` (línea 14),
que guarda la instancia en la propiedad estática `$instance` y la crea
únicamente la primera vez que se la pide.

Con esto, `PaymentService` e `InventoryService` pasarían a usar
`Logger::getInstance()->log(...)` en vez de `new Logger()`, y los dos
compartirían el mismo `$messageCount` — exactamente lo que el demo al final
del archivo verifica comparando `Logger::getInstance() === $sameLogger`.
