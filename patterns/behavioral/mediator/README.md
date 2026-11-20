# Mediator

**Categoría:** Comportamiento

## Problema

Varios objetos se comunican directamente entre sí (cada widget de un
formulario conoce a todos los demás para validarse), formando una red de
dependencias cruzadas difícil de seguir y de modificar sin romper algo en
otro lado.

## Solución

Introduces un objeto "mediador" por el que pasa toda la comunicación: los
objetos ya no se conocen entre sí, solo conocen al mediador y le avisan
cuando algo pasa (`mediador.notificar(this, evento)`); el mediador decide
qué hacer y a quién más avisar.

## Cuándo usarlo

- Formularios de UI con muchos campos interdependientes.
- Coordinación de componentes que de otra forma tendrían referencias
  cruzadas entre todos ellos (complejidad O(n²) de referencias).

## Dónde lo vas a encontrar en la vida real

- Una sala de chat: los mensajes pasan por un servidor central (el mediador)
  en vez de que cada usuario le hable directo a todos los demás.
- El control de tráfico aéreo: los aviones no se coordinan entre sí, todos
  hablan con la torre de control.
- El "controller" de un formulario complejo, que habilita o deshabilita
  botones según el estado combinado de varios campos, sin que los campos se
  conozcan entre sí.
- Un broker de mensajes como RabbitMQ o Kafka, que media entre quien produce
  un evento y quien lo consume sin que se conozcan directamente.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
