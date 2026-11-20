# Proxy

**Categoría:** Estructural

## Problema

Quieres controlar el acceso a un objeto — retrasar su creación porque es
costosa (lazy loading), validar permisos antes de dejar pasar una llamada,
cachear resultados, o loguear cada acceso — sin que el código cliente ni
el objeto real tengan que saber nada de eso.

## Solución

Creas un "proxy" que implementa la misma interfaz que el objeto real, y
que el cliente usa exactamente igual. Por dentro, el proxy decide cuándo y
cómo delegar la llamada al objeto real (creándolo si hace falta,
chequeando permisos, cacheando, etc.).

## Variantes comunes

- **Virtual proxy**: crea el objeto real solo cuando realmente se necesita.
- **Protection proxy**: valida permisos antes de delegar.
- **Caching proxy**: guarda resultados de llamadas costosas.
- **Logging proxy**: registra cada llamada.

## Diferencia con Decorator

Son estructuralmente casi idénticos. La diferencia es de **intención**:
Decorator añade *responsabilidades nuevas*; Proxy controla el *acceso* al
objeto real sin cambiar lo que hace.

## Dónde lo vas a encontrar en la vida real

- El "lazy loading" de imágenes en una página web: ves un placeholder hasta
  que la imagen real entra en pantalla y recién ahí se descarga.
- El objeto `Proxy` nativo de JavaScript, que usa Vue 3 por debajo para
  detectar cuándo cambiás una propiedad de un objeto reactivo.
- Las entidades relacionadas en Hibernate o Entity Framework: acceder a
  `pedido.Cliente` dispara recién ahí la consulta a la base de datos (un
  proxy "perezoso").
- Un proxy reverso como Nginx delante de tus servidores reales, controlando
  acceso, cacheando respuestas y repartiendo tráfico.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
