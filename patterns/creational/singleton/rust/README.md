# Singleton en Rust

## El problema, en código

En Rust no podés simplemente tener una variable global mutable sin más —
el compilador no te deja sin forzar `unsafe`. El error típico, entonces, es
crear una instancia nueva de `Logger` dentro de cada función o struct que
la necesita:

```rust
struct Logger {
    message_count: u32,
}

impl Logger {
    fn new() -> Self {
        Logger { message_count: 0 }
    }

    fn log(&mut self, message: &str) {
        self.message_count += 1;
        println!("[{}] {}", self.message_count, message);
    }
}

struct PaymentService {
    logger: Logger, // crea SU PROPIA instancia
}

struct InventoryService {
    logger: Logger, // y esta es OTRA instancia distinta
}
```

`PaymentService` e `InventoryService` terminan cada uno con su propio
`message_count`, así que el número entre corchetes de cada log arranca de
cero en cada servicio en vez de reflejar "mensaje #N de toda la app". Y como
cada uno es dueño de su propio `Logger`, no hay forma de compartir ese
estado entre los dos sin pasarse referencias por todos lados — justo lo que
el Singleton evita.

## Así queda con Singleton aplicado

Mirá [`singleton.rs`](singleton.rs) de esta carpeta: en vez de que cada
quien cree su propio `Logger`, hay un `static` de tipo `OnceLock<Logger>`
(línea 17) adentro de la función asociada `Logger::instance()`. `OnceLock`
garantiza, de forma segura entre threads, que el closure que crea el
`Logger` (`Logger::new`) se ejecute una sola vez la primera vez que alguien
llama a `instance()` — las llamadas siguientes devuelven una referencia al
mismo objeto ya creado. El contador interno usa `Mutex<u32>` (línea 8) para
poder mutarse de forma segura incluso a través de una referencia compartida
`&'static Logger`.

Con esto, `PaymentService` e `InventoryService` pasarían a llamar
`Logger::instance().log(...)` en vez de tener su propio campo `logger`, y
los dos compartirían el mismo contador — exactamente lo que el `main`
verifica con `std::ptr::eq(Logger::instance(), same_logger)`.
