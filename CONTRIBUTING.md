# Contribuir

Gracias por querer sumar un patrón o un lenguaje. Reglas simples:

1. **Un ejemplo, una idea.** Cada implementación debe mostrar *solo* el
   patrón, sin lógica de negocio extra ni abstracciones que no hagan falta
   para entenderlo.
2. **Debe compilar/ejecutar.** Si agregas código, probá que corre con los
   comandos de la tabla del [README](README.md#cómo-ejecutar-cada-ejemplo)
   antes de abrir el PR.
3. **Comentarios en inglés, explicación en español.** El código usa
   comentarios cortos en inglés (estándar de la industria); el `README.md`
   de cada patrón explica el *qué* y el *por qué* en español.
4. **Respeta la estructura:**
   ```
   patterns/<categoria>/<patron>/<lenguaje>/
   ```
   donde `<categoria>` es `creational`, `structural` o `behavioral`.
5. **Actualiza la tabla de estado** en el README principal si completas una
   celda (⬜ → ✅).
6. **Nombra los archivos de forma idiomática** al lenguaje (p. ej.
   `Singleton.java`, `singleton.rs`, `singleton.php`), no uses un nombre
   genérico como `main` salvo que sea lo normal en ese lenguaje.

Si quieres agregar un patrón nuevo que no está en la lista de los 23 GoF
(por ejemplo Repository, DI Container, CQRS), abre primero un issue para
discutir dónde encajaría.
