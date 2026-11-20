# State

**Categoría:** Comportamiento

## Problema

Un objeto cambia su comportamiento según su "estado" interno (un pedido
que puede estar `Pendiente`, `Pagado`, `Enviado`, `Cancelado`, y cada
método se comporta distinto según cuál sea), y el código termina lleno de
`if estado == X` / `switch(estado)` repetidos en cada método.

## Solución

Extraes cada estado a su propia clase que implementa una interfaz común de
comportamiento. El objeto principal mantiene una referencia al "estado
actual" y le delega el trabajo; cada clase de estado sabe, además, a qué
otro estado transicionar y cuándo (reemplazando la referencia en el
objeto principal).

## Cuándo usarlo

- Máquinas de estado con comportamiento (no solo datos) distinto por
  estado, y transiciones bien definidas entre ellos.

## Diferencia con Strategy

Estructuralmente son casi iguales. La diferencia es de intención: en
Strategy el cliente elige la estrategia; en State, los propios estados
deciden cuándo transicionar a otro.

## Dónde lo vas a encontrar en la vida real

- Un reproductor de video o música: el botón de "Play" hace algo distinto
  según si el estado actual es Reproduciendo, Pausado o Detenido.
- Un pedido de e-commerce: las acciones disponibles cambian solo con que el
  pedido pase de Pendiente a Pagado a Enviado a Entregado.
- Las conexiones TCP, que tienen estados bien definidos (Cerrado,
  Escuchando, Establecido) con reglas distintas de qué se puede hacer en
  cada uno.
- Las puertas automáticas de un ascensor: se comportan distinto si están
  Abriendo, Cerrando o Bloqueadas por un sensor.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
