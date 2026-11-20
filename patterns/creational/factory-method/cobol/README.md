# Factory Method en COBOL

## El problema, en código

Tu sistema genera reportes y, al principio, solo exportaba a PDF. Varios
programas distintos (el batch de reportes, el job nocturno, el programa que
dispara el operador) terminaron con su propia copia de esta lógica:

```cobol
*> en report-controller.cbl, nightly-export-job.cbl, y export-button.cbl...
invoke pdf-document "new" returning doc
invoke doc "render" returning the-text
display function trim(the-text)
```

Ahora el negocio pide poder exportar a Word también. Tenés que ir a buscar
**cada uno** de esos programas y convertirlos en un `evaluate tipo when
"PDF" ... when "WORD" ...`. Si te olvidás de actualizar uno (el job
nocturno, por ejemplo, porque nadie se acordaba de que también instanciaba
documentos), ese programa se queda exportando siempre PDF aunque el usuario
haya pedido Word, y nadie se entera hasta que alguien se queja.

## Así queda con Factory Method aplicado

Mirá [`factory_method.cbl`](factory_method.cbl) de esta carpeta: la clase
`document-creator` (línea 38) declara el método `create-document` (línea
45) — ese es el "método de fábrica" — y lo usa en `open` (línea 52) con
`invoke self "create-document"`, sin saber nunca qué clase concreta le
responde. `pdf-creator` y `word-creator` (líneas 67 y 87) son las únicas
clases del código que mencionan `invoke pdf-document "new"` o
`invoke word-document "new"`.

`report-controller`, `nightly-export-job` y `export-button` ya no
instanciarían ningún documento directamente: recibirían una referencia a un
`document-creator` (`pdf-creator` o `word-creator`) y llamarían a
`invoke creator "open"`. El párrafo principal muestra el cambio sin ningún
`evaluate`: crear un `pdf-creator` o un `word-creator` es lo único que
cambia (líneas 120 y 124); la lógica de "abrir y renderizar" es una sola y
vive en un solo lugar. Agregar `excel-creator` mañana no toca ninguno de los
tres programas de arriba.
