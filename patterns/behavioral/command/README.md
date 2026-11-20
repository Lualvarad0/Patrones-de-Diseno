# Command

**Categoría:** Comportamiento

## Problema

Tu control remoto necesita un botón "deshacer". Si el control llama
directo a los métodos del dispositivo (`light.TurnOn()`,
`light.TurnOff()`), nunca queda un registro de qué se ejecutó — el
control olvida la acción apenas termina de ejecutarla, así que no hay
forma de deshacer la última sin que el control empiece a conocer los
detalles de cada dispositivo y de cada acción posible.

## Solución

Encapsulas una petición en un objeto con una interfaz común
(`ejecutar()`, opcionalmente `deshacer()`), que guarda todo lo necesario
para ejecutarla (el receptor y sus parámetros). Quien dispara el comando
no necesita saber qué hace exactamente, solo llama a `ejecutar()`.

## Cuándo usarlo

- Implementar undo/redo.
- Colas de tareas, operaciones programadas o diferidas.
- Botones/menús de UI configurables donde cada acción es intercambiable.

## Dónde lo vas a encontrar en la vida real

- Un botón de "Cortar" en un editor: el mismo comando se puede disparar
  desde el botón, un atajo de teclado y un ítem de menú, todos ejecutando
  exactamente lo mismo.
- El undo/redo (Ctrl+Z / Ctrl+Y) de cualquier editor: cada edición se guarda
  como un comando que sabe cómo deshacerse a sí mismo.
- Las colas de trabajos en segundo plano (Sidekiq, Laravel Queues, Celery):
  una tarea se serializa como un "comando" y se ejecuta después, a veces en
  otro proceso.
- Un control remoto universal donde cada botón ejecuta un comando distinto
  sobre el dispositivo conectado.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
