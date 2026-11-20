# Factory Method en C#

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el controlador web, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```csharp
// En ReportController.cs
var document = new PdfDocument();
Console.WriteLine(document.Render());

// En NightlyExportJob.cs
var document = new PdfDocument();
Console.WriteLine(document.Render());

// En ExportButtonHandler.cs
var document = new PdfDocument();
Console.WriteLine(document.Render());
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `if (tipo == "pdf") ...
else ...`. Si te olvidás de actualizar uno (el job nocturno, por ejemplo,
porque nadie se acordaba de que también instanciaba documentos), ese lugar
se queda exportando siempre PDF aunque el usuario haya pedido Word, y nadie
se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `DocumentCreator` (línea
20) define `CreateDocument()` como `abstract` (línea 22) — ese es el
"método de fábrica" — y usa su resultado en `Open()` (línea 24) sin saber
nunca qué clase concreta le llegó. `PdfCreator` y `WordCreator` (líneas 31 y
36) son los únicos lugares del código que mencionan `new PdfDocument()` o
`new WordDocument()`.

`ReportController`, `NightlyExportJob` y `ExportButtonHandler` ya no
instancian nada: reciben un `DocumentCreator` (por constructor o
configuración) y llaman a `creator.Open()`. El `Main` muestra el cambio sin
ningún `if`: crear un `PdfCreator` o un `WordCreator` es lo único que
cambia (líneas 45-48); la lógica de "abrir y renderizar" es una sola y vive
en un solo lugar. Agregar `ExcelCreator` mañana no toca ninguno de los tres
archivos de arriba.
