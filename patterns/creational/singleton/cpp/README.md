# Singleton en C++

## El problema, en código

Imaginá una clase `Logger` común, con constructor público, usada por varios
servicios del backend de una tienda online:

```cpp
class Logger {
public:
    void log(const std::string& message) {
        messageCount++;
        std::cout << "[" << messageCount << "] " << message << std::endl;
    }
private:
    int messageCount = 0;
};

class PaymentService {
    Logger logger; // crea SU PROPIA instancia
public:
    void charge(double amount) { logger.log("Charged $" + std::to_string(amount)); }
};

class InventoryService {
    Logger logger; // y esta es OTRA instancia distinta
public:
    void restock(int qty) { logger.log("Restocked " + std::to_string(qty) + " units"); }
};
```

Cada servicio tiene su propio `messageCount`, así que el número entre
corchetes de cada log arranca de cero en cada servicio en vez de reflejar
"mensaje #N de toda la app". Y nada impide que alguien haga
`Logger logger2 = logger;` y copie el objeto por accidente, duplicando
también ese estado.

## Así queda con Singleton aplicado

Mirá [`singleton.cpp`](singleton.cpp) de esta carpeta: el constructor es
`private` (línea 23), así que `Logger logger;` fuera de la propia clase
directamente **no compila**. La única puerta de entrada es el método
estático `Logger::instance()` (línea 7), que usa una variable **local
estática** (`static Logger instance;`, línea 9) — desde C++11 el estándar
garantiza que su inicialización ocurre una sola vez y es segura entre
threads, sin que tengas que escribir ningún lock a mano. Además, el copy
constructor y el operator= están explícitamente borrados (`= delete`,
líneas 17-18), así que ni siquiera copiando el objeto se puede duplicar la
instancia.

Con esto, `PaymentService` e `InventoryService` pasarían a usar
`Logger::instance().log(...)` en vez de tener su propio campo `logger`, y
los dos compartirían el mismo `messageCount` — exactamente lo que `main`
verifica comparando `&Logger::instance() == &sameLogger`.
