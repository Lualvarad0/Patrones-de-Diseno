# Decorator en COBOL

## El problema, en código

Estás armando el sistema de pedidos de una cafetería (tipo app de
Starbucks). Un café puede llevar leche, o no; azúcar, o no — y cada
combinación cambia el precio y la descripción. El primer instinto es una
clase COBOL por combinación:

```cobol
*> una clase por combinación...
class-id. coffee-with-milk.
object.
    procedure division.
    method-id. description.
        procedure division returning result as pic x(40).
            move "Coffee + Milk" to result
        end method description.
    method-id. cost.
        procedure division returning result as pic 9(3)v99.
            move 2.50 to result
        end method cost.
end object.
end class coffee-with-milk.

*> ...y otra clase casi idéntica para cada combinación más:
*> coffee-with-sugar, coffee-with-milk-and-sugar, coffee-with-crema,
*> coffee-with-milk-and-crema, coffee-with-sugar-and-crema...
```

Con solo 2 extras ya tenés 4 clases casi idénticas. Con 4 extras (leche,
azúcar, crema, shot extra) son 16 combinaciones posibles, y agregar un
quinto extra (canela) duplica otra vez la cantidad de clases que tendrías
que escribir y mantener — aunque la única diferencia real entre ellas sea
sumar un precio y concatenar un texto.

## Así queda con Decorator aplicado

Mirá [`decorator.cbl`](decorator.cbl) de esta carpeta: en vez de una clase
por combinación, cada extra es una clase "decoradora" independiente
(`milk-decorator`, `sugar-decorator`, líneas 28 y 67) que guarda una
referencia al objeto que envuelve en `wrapped` (método `init`, líneas 36 y
75) y, en sus métodos `description`/`cost`, primero le pide el resultado al
objeto envuelto con `invoke wrapped "description"` y después le suma su
propia parte encima.

El párrafo principal arma la combinación "al vuelo" (líneas 125-131):
crea un `simple-coffee`, lo envuelve con `milk-decorator` llamando a
`init`, y envuelve ese resultado con `sugar-decorator` llamando a `init` de
nuevo — y lee el resultado final solo del envoltorio más externo
(`with-sugar`). Agregar un extra de "crema" mañana es escribir **una sola
clase nueva** (`crema-decorator`), que se puede combinar con las que ya
existen en cualquier orden — nunca 16 clases, siempre tantas clases como
extras tengas.
