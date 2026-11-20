# Factory Method en Rust

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el handler web, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```rust
// En report_controller.rs
let document = PdfDocument;
println!("{}", document.render());

// En nightly_export_job.rs
let document = PdfDocument;
println!("{}", document.render());

// En export_button_handler.rs
let document = PdfDocument;
println!("{}", document.render());
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `match tipo { "pdf" => ...,
"word" => ... }`. Si te olvidás de actualizar uno (el job nocturno, por
ejemplo, porque nadie se acordaba de que también instanciaba documentos),
ese lugar se queda exportando siempre PDF aunque el usuario haya pedido
Word, y nadie se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`factory_method.rs`](factory_method.rs) de esta carpeta: el trait
`DocumentCreator` (línea 24) declara `create_document()` (línea 25) — ese es
el "método de fábrica" — y provee `open()` (línea 27) con una
implementación por defecto que usa ese método sin saber nunca qué tipo
concreto devuelve. `PdfCreator` y `WordCreator` (líneas 32 y 39) son los
únicos lugares del código que mencionan `PdfDocument` o `WordDocument`
directamente.

`report_controller.rs`, `nightly_export_job.rs` y
`export_button_handler.rs` ya no instancian nada: reciben un
`Box<dyn DocumentCreator>` y llaman a `creator.open()`. El `main` muestra el
cambio sin ningún `match`: crear un `PdfCreator` o un `WordCreator` es lo
único que cambia (líneas 47-50); la lógica de "abrir y renderizar" es una
sola y vive en un solo lugar. Agregar `ExcelCreator` mañana no toca ninguno
de los tres archivos de arriba.
