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

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
