# Observer

**Categoría:** Comportamiento

## Problema

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Si `WeatherStation` conoce a cada
display por su tipo concreto y los llama a mano
(`phone.Update(temperatura); tv.Update(temperatura);`), queda acoplada a
cada tipo de display que exista — agregar o quitar uno implica editar
ese método cada vez.

## Solución

Los interesados ("observadores") se **suscriben** al sujeto implementando
una interfaz común (`notificar(evento)`). El sujeto mantiene una lista de
observadores suscritos y, cuando cambia, simplemente recorre la lista y
llama a `notificar()` en cada uno, sin saber (ni importarle) qué hace cada
observador con esa información.

## Cuándo usarlo

- Cuando el cambio de un objeto debe disparar efectos en un número variable
  y desconocido de otros objetos (eventos de UI, pub/sub, sistemas
  reactivos).

## Cuidado con

- Fugas de memoria si los observadores no se desuscriben cuando ya no se
  necesitan (muy común en listeners de UI de larga vida).
- El orden de notificación no suele estar garantizado — no diseñes lógica
  que dependa de "quién se entera primero".

## Dónde lo vas a encontrar en la vida real

- `addEventListener` en el navegador: toda la Web está armada sobre este
  patrón — un botón "notifica" a quien se haya suscrito a su evento `click`.
- El `EventEmitter` de Node.js, usado por dentro de streams, servidores HTTP
  y un montón de librerías.
- Los sistemas reactivos como RxJS, o cómo React/Vue vuelven a renderizar un
  componente automáticamente cuando cambia el estado del que depende.
- Suscribirte a un canal de YouTube o a una newsletter: te avisan cada vez
  que hay contenido nuevo, sin que vos tengas que estar preguntando todo el
  tiempo.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
