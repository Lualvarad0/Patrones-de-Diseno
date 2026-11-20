# Command en COBOL

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el párrafo
del control invoca directo los métodos del dispositivo:

```cobol
*> no hay dónde guardar "qué se hizo" para poder deshacerlo:
*> el párrafo olvida la acción apenas termina de ejecutarla
invoke the-light "turn-on"
*> ...más adelante...
invoke the-light "turn-off"
*> si ahora querés deshacer la última acción, ¿cuál fue? el programa no lo sabe
```

El programa nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el párrafo empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`command.cbl`](command.cbl) de esta carpeta: `turn-on-command`
(línea 24) y `turn-off-command` (línea 48) envuelven cada acción como un
objeto con los mismos mensajes `"execute"` y `"undo"` — uno invoca
`the-light "turn-on"` dentro de `execute` (línea 37) y `the-light
"turn-off"` dentro de `undo` (línea 41), y el otro al revés.
`remote-control` (línea 72) nunca invoca `light` directamente: `submit`
(línea 81) ejecuta el comando que le pasen con `invoke command "execute"`
y lo guarda en `history-table` (línea 87), sin saber qué dispositivo ni
qué acción hay detrás.

El párrafo principal (línea 122) manda dos comandos con `"submit"`
(líneas 132-133) y después invoca `remote "undo-last"` (línea 134): el
control saca el último comando de `history-table` (líneas 94-98) y le
invoca `"undo"` sin necesitar un `if` que distinga "era un turn-on-command
o un turn-off-command".
