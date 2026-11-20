# Factory Method en JavaScript

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el controlador web, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```js
// En reportController.js
const document = new PdfDocument();
console.log(document.render());

// En nightlyExportJob.js
const document = new PdfDocument();
console.log(document.render());

// En exportButtonHandler.js
const document = new PdfDocument();
console.log(document.render());
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `if (tipo === "pdf") ...
else ...`. Si te olvidás de actualizar uno (el job nocturno, por ejemplo,
porque nadie se acordaba de que también instanciaba documentos), ese lugar
se queda exportando siempre PDF aunque el usuario haya pedido Word, y nadie
se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`factory-method.js`](factory-method.js) de esta carpeta:
`DocumentCreator` (línea 17) define `createDocument()` lanzando un error por
defecto (línea 19) — es la forma de simular un "método abstracto" en
JavaScript — y usa su resultado en `open()` (línea 22) sin saber nunca qué
clase concreta le llegó. `PdfCreator` y `WordCreator` (líneas 28 y 34) son
las únicas clases del código que mencionan `new PdfDocument()` o
`new WordDocument()`.

`reportController.js`, `nightlyExportJob.js` y `exportButtonHandler.js` ya
no instancian nada: reciben un `DocumentCreator` (como parámetro o import
configurado) y llaman a `creator.open()`. El bloque de demo muestra el
cambio sin ningún `if`: crear un `PdfCreator` o un `WordCreator` es lo único
que cambia (líneas 41-44); la lógica de "abrir y renderizar" es una sola y
vive en un solo lugar. Agregar `ExcelCreator` mañana no toca ninguno de los
tres archivos de arriba.
