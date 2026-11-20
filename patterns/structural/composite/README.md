# Composite

**Categoría:** Estructural

## Problema

Necesitás calcular el tamaño total de una carpeta de proyecto que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin un diseño que
unifique ambos casos, cada función que recorre el árbol (calcular tamaño,
imprimir, buscar un archivo) tiene que preguntar todo el tiempo "¿esto es
un archivo o una carpeta?" antes de decidir cómo tratarlo — y agregar un
tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar todas esas
funciones.

## Solución

Defines una interfaz común para hojas y contenedores (ej. `mostrar()`,
`calcularTamaño()`). El contenedor implementa esa misma interfaz
delegando/agregando el resultado de llamar al mismo método en cada uno de
sus hijos (que pueden ser hojas u otros contenedores). El cliente llama al
método en la raíz y la recursión ocurre sola.

## Cuándo usarlo

- Cualquier estructura jerárquica tipo árbol donde quieres operar sobre el
  todo y sobre las partes de manera uniforme.

## Dónde lo vas a encontrar en la vida real

- El sistema de archivos de tu computadora: una carpeta y un archivo se
  tratan con las mismas operaciones (ver tamaño, mover, eliminar), aunque la
  carpeta en realidad contenga más archivos adentro.
- El DOM de cualquier página web: un nodo de texto y un `<div>` con cientos
  de hijos implementan la misma interfaz `Node`.
- El árbol de componentes de React, Angular o Swing: un `Panel` con botones
  adentro se trata igual que un botón suelto a la hora de renderizar.
- Un menú de aplicación con submenús: hacer clic en "Archivo" dispara lo
  mismo esté o no anidado dentro de otro menú.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
