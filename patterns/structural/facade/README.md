# Facade

**Categoría:** Estructural

## Problema

Un subsistema tiene muchas clases, con relaciones e interfaces complejas
entre ellas, y la mayoría del código cliente solo necesita una operación
simple de alto nivel — pero termina teniendo que conocer y coordinar todas
esas clases internas.

## Solución

Creas una clase "fachada" con una interfaz simple que, por dentro, conoce
y coordina las piezas del subsistema complejo. El cliente habla solo con
la fachada; el subsistema sigue existiendo y puede seguir usándose
directamente por quien lo necesite.

## Cuándo usarlo

- Para dar un punto de entrada simple a una librería o subsistema complejo.
- Para desacoplar el código cliente de los detalles internos de un
  subsistema que cambia con frecuencia.

## Cuándo NO usarlo

- Si la fachada termina exponiendo casi todos los métodos del subsistema
  igual, no está simplificando nada — revisa si de verdad reduce la
  complejidad percibida por el cliente.

## Dónde lo vas a encontrar en la vida real

- jQuery en su momento: una interfaz simple (`$("#id").hide()`) escondiendo
  toda la complicación de manipular el DOM a mano entre navegadores
  distintos.
- Un servicio `PaymentService.cobrar()` en tu app que por dentro valida
  fraude, llama a la pasarela de pago y manda el email de recibo — el resto
  del código solo llama a ese método.
- `Mail::send()` en Laravel y métodos similares en otros frameworks:
  esconden colas, proveedores SMTP y plantillas detrás de una sola llamada.
- El botón de "Imprimir" de cualquier programa: por dentro coordina el
  spooler, el driver de la impresora y el diálogo de configuración, pero vos
  solo apretás un botón.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
