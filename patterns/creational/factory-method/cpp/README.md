# Factory Method en C++

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el controlador, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```cpp
// En ReportController.cpp
auto document = std::make_unique<PdfDocument>();
std::cout << document->render() << std::endl;

// En NightlyExportJob.cpp
auto document = std::make_unique<PdfDocument>();
std::cout << document->render() << std::endl;

// En ExportButtonHandler.cpp
auto document = std::make_unique<PdfDocument>();
std::cout << document->render() << std::endl;
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `if (tipo == "pdf") ...
else ...`. Si te olvidás de actualizar uno (el job nocturno, por ejemplo,
porque nadie se acordaba de que también instanciaba documentos), ese lugar
se queda exportando siempre PDF aunque el usuario haya pedido Word, y nadie
se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`factory_method.cpp`](factory_method.cpp) de esta carpeta:
`DocumentCreator` (línea 25) declara `createDocument()` como virtual puro
(línea 27) — ese es el "método de fábrica" — y lo usa en `open()` (línea
29) sin saber nunca qué clase concreta le llegó. `PdfCreator` y
`WordCreator` (líneas 37 y 44) son las únicas clases del código que
mencionan `std::make_unique<PdfDocument>()` o
`std::make_unique<WordDocument>()`.

`ReportController`, `NightlyExportJob` y `ExportButtonHandler` ya no
instancian nada: reciben un `std::unique_ptr<DocumentCreator>` y llaman a
`creator->open()`. El `main` muestra el cambio sin ningún `if`: crear un
`PdfCreator` o un `WordCreator` es lo único que cambia (líneas 52-55); la
lógica de "abrir y renderizar" es una sola y vive en un solo lugar. Agregar
`ExcelCreator` mañana no toca ninguno de los tres archivos de arriba.
