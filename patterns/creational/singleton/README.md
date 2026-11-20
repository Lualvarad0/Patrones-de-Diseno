# Singleton

**Categoría:** Creacional

## Problema

A veces necesitas que **exista una sola instancia** de una clase en toda la
aplicación (una conexión a configuración, un logger, un contador global) y
que cualquier parte del código pueda acceder a ella sin pasarla como
parámetro por todos lados.

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

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
