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

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
