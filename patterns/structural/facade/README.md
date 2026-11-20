# Facade

**Categoría:** Estructural

## Problema

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Prender la película implica seis llamadas en el orden correcto a
tres clases distintas (`Amplifier`, `Projector`, `DvdPlayer`), y cada
pantalla que necesita ese botón repite el mismo bloque de seis llamadas.
Si mañana cambia el orden correcto, o agregás una cuarta clase (luces, por
ejemplo), hay que encontrar y corregir cada copia de esa secuencia.

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
