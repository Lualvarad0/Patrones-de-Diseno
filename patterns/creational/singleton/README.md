# Singleton

**Categoría:** Creacional

## Problema

Estás construyendo el backend de una tienda online. El módulo de pagos y el
módulo de inventario necesitan loguear lo que hacen, así que cada uno crea
su propia instancia de `Logger`. El resultado: cada instancia lleva su
propio contador de mensajes (el log del módulo de pagos arranca en "[1]"
igual que el de inventario, aunque uno haya pasado por la aplicación mucho
antes que el otro), y si `Logger` escribiera a un archivo en disco, cada
instancia abriría su propio handle al mismo archivo — con el riesgo real de
que dos escrituras casi simultáneas corten o pisen la línea de la otra.
Necesitás que **exista una sola instancia compartida**, a la que cualquier
módulo pueda acceder sin que nadie tenga que pasársela por parámetro.

Esto no es exclusivo de los loggers: pasa igual con un pool de conexiones a
base de datos, o con la configuración de la app leída una sola vez al
arrancar.

## Solución

La propia clase controla su instanciación: guarda su única instancia en un
campo estático/privado y expone un método o propiedad estático
(`getInstance()`, `Instance`, etc.) que la crea la primera vez y devuelve
siempre la misma después. El constructor se vuelve privado para que nadie
más pueda crear otra instancia con `new`.

## Cuándo usarlo

- Cuando de verdad solo debe existir una instancia (no "me conviene que haya
  una", sino que tener dos rompería algo).
- Configuración global, pools de conexiones, loggers.

## Cuándo NO usarlo

- Es fácil abusar de él para esconder estado global y dificultar los tests.
  En la mayoría de frameworks modernos esto se resuelve mejor con
  **inyección de dependencias** registrando el servicio como "singleton" en
  el contenedor, en vez de forzarlo a nivel de clase.

## Dónde lo vas a encontrar en la vida real

- El logger de casi cualquier framework (Log4j, Serilog, el `console` del
  navegador): una sola instancia que todo el código usa para escribir
  mensajes.
- La configuración que se carga una vez al arrancar la app (`appsettings.json`,
  variables de entorno) y se reutiliza en todos lados.
- `Runtime.getRuntime()` en Java, o el objeto `window` del navegador:
  siempre es el mismo objeto, sin importar desde dónde lo pidas.
- Los servicios que registrás como `Singleton` en el contenedor de
  inyección de dependencias de ASP.NET Core, Spring o NestJS.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
