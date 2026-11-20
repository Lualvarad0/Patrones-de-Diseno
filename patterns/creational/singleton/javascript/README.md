# Singleton en JavaScript

## El problema, en código

En Node, el error típico es exportar la **clase** en vez de una instancia,
y dejar que cada archivo cree la suya:

```js
// logger.js — mal: exporta la clase, no una instancia
class Logger {
  #messageCount = 0;
  log(message) {
    this.#messageCount++;
    console.log(`[${this.#messageCount}] ${message}`);
  }
}
module.exports = Logger;

// payment-service.js
const Logger = require("./logger");
const logger = new Logger(); // crea SU PROPIA instancia

// inventory-service.js
const Logger = require("./logger");
const logger = new Logger(); // y esta es OTRA instancia distinta
```

`payment-service.js` e `inventory-service.js` terminan cada uno con su
propio `#messageCount` privado, así que el número entre corchetes de cada
log arranca de cero en cada archivo en vez de reflejar "mensaje #N de toda
la app". Si mañana `Logger` necesitara, por ejemplo, abrir un stream de
escritura a un archivo (`fs.createWriteStream`), cada instancia abriría el
suyo propio al mismo archivo, con el riesgo de que dos escrituras casi
simultáneas se pisen entre sí.

## Así queda con Singleton aplicado

Mirá [`singleton.js`](singleton.js) de esta carpeta: en vez de exportar la
clase, el módulo crea **una sola instancia** (`const instance = new
Logger()`, al final del archivo) y exporta esa instancia ya creada
(`module.exports = instance`). Esto funciona porque Node cachea los módulos
la primera vez que se cargan — un `require("./singleton")` posterior, desde
cualquier archivo, devuelve el mismo objeto en caché, no una copia nueva.

Con esto, `payment-service.js` e `inventory-service.js` pasarían a hacer
`const logger = require("./singleton")` y los dos compartirían el mismo
`#messageCount` — exactamente lo que el bloque de demo de este archivo
verifica comparando `logger1 === logger2`.
