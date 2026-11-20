# Factory Method en PHP

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el controlador, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```php
// En ReportController.php
$document = new PdfDocument();
echo $document->render() . "\n";

// En NightlyExportJob.php
$document = new PdfDocument();
echo $document->render() . "\n";

// En ExportButtonHandler.php
$document = new PdfDocument();
echo $document->render() . "\n";
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `if ($tipo === 'pdf') ...
else ...`. Si te olvidás de actualizar uno (el job nocturno, por ejemplo,
porque nadie se acordaba de que también instanciaba documentos), ese lugar
se queda exportando siempre PDF aunque el usuario haya pedido Word, y nadie
se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`FactoryMethod.php`](FactoryMethod.php) de esta carpeta:
`DocumentCreator` (línea 27) declara `createDocument()` como `abstract`
(línea 29) — ese es el "método de fábrica" — y lo usa en `open()` (línea
31) sin saber nunca qué clase concreta le llegó. `PdfCreator` y
`WordCreator` (líneas 38 y 46) son las únicas clases del código que
mencionan `new PdfDocument()` o `new WordDocument()`.

`ReportController`, `NightlyExportJob` y `ExportButtonHandler` ya no
instancian nada: reciben un `DocumentCreator` (por constructor) y llaman a
`$creator->open()`. El bloque de demo muestra el cambio sin ningún `if`:
crear un `PdfCreator` o un `WordCreator` es lo único que cambia (líneas
55-58); la lógica de "abrir y renderizar" es una sola y vive en un solo
lugar. Agregar `ExcelCreator` mañana no toca ninguno de los tres archivos de
arriba.
