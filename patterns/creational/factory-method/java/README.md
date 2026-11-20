# Factory Method en Java

## El problema, en código

Tu app genera reportes y, al principio, solo exportaba a PDF. Varias partes
del código (el controlador web, el job nocturno, el botón de "Exportar")
terminaron con su propia copia de esta lógica:

```java
// En ReportController.java
Document document = new PdfDocument();
System.out.println(document.render());

// En NightlyExportJob.java
Document document = new PdfDocument();
System.out.println(document.render());

// En ExportButtonHandler.java
Document document = new PdfDocument();
System.out.println(document.render());
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos lugares y convertirlo en un `if (tipo.equals("pdf"))
... else ...`. Si te olvidás de actualizar uno (el job nocturno, por
ejemplo, porque nadie se acordaba de que también instanciaba documentos),
ese lugar se queda exportando siempre PDF aunque el usuario haya pedido
Word, y nadie se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`FactoryMethodDemo.java`](FactoryMethodDemo.java) de esta carpeta:
`DocumentCreator` (línea 17) declara `createDocument()` como `abstract`
(línea 18) — ese es el "método de fábrica" — y usa su resultado en
`open()` (línea 20) sin saber nunca qué clase concreta le llegó.
`PdfCreator` y `WordCreator` (líneas 26 y 30) son las únicas clases del
código que mencionan `new PdfDocument()` o `new WordDocument()`.

`ReportController`, `NightlyExportJob` y `ExportButtonHandler` ya no
instancian nada: reciben un `DocumentCreator` (por constructor o inyección
de dependencias) y llaman a `creator.open()`. El `main` muestra el cambio
sin ningún `if`: crear un `PdfCreator` o un `WordCreator` es lo único que
cambia (líneas 36-39); la lógica de "abrir y renderizar" es una sola y vive
en un solo lugar. Agregar `ExcelCreator` mañana no toca ninguno de los tres
archivos de arriba.
