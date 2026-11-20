      *> Builder in Object-Oriented COBOL (GnuCOBOL).
      *> "pizza-builder" configures a pizza step by step; each "with-"/
      *> "add-" method returns the builder itself (self) so the caller
      *> keeps calling methods on the same object, then "build" produces
      *> the final description.
      *> Compile with:  cobc -x -free builder.cbl -o builder
       >>SOURCE FORMAT FREE
       identification division.
       class-id. pizza-builder.

       object.
           working-storage section.
           01 the-size      pic x(10) value "medium".
           01 has-cheese    pic 9 value 0.
           01 has-pepperoni pic 9 value 0.
           01 has-mushrooms pic 9 value 0.

           procedure division.

           method-id. with-size.
               linkage section.
               01 size-in pic x(10).
               procedure division using size-in returning result as object reference.
                   move size-in to the-size
                   move self to result
               end method with-size.

           method-id. add-cheese.
               procedure division returning result as object reference.
                   move 1 to has-cheese
                   move self to result
               end method add-cheese.

           method-id. add-pepperoni.
               procedure division returning result as object reference.
                   move 1 to has-pepperoni
                   move self to result
               end method add-pepperoni.

           method-id. add-mushrooms.
               procedure division returning result as object reference.
                   move 1 to has-mushrooms
                   move self to result
               end method add-mushrooms.

           method-id. build.
               working-storage section.
               01 toppings pic x(40).
               procedure division returning result as pic x(60).
                   move spaces to toppings
                   if has-cheese = 1
                       string function trim(toppings) delimited by size
                           "cheese " delimited by size
                           into toppings
                   end-if
                   if has-pepperoni = 1
                       string function trim(toppings) delimited by size
                           "pepperoni " delimited by size
                           into toppings
                   end-if
                   if has-mushrooms = 1
                       string function trim(toppings) delimited by size
                           "mushrooms " delimited by size
                           into toppings
                   end-if
                   if has-cheese = 0 and has-pepperoni = 0 and has-mushrooms = 0
                       move "no toppings" to toppings
                   end-if
                   move spaces to result
                   string function trim(the-size) delimited by size
                       " pizza with " delimited by size
                       function trim(toppings) delimited by size
                       into result
               end method build.

       end object.
       end class pizza-builder.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class pizza-builder.

       data division.
       working-storage section.
       01 pz      object reference.
       01 result-text pic x(60).

       procedure division.
           invoke pizza-builder "new" returning pz
           invoke pz "with-size" using "large" returning pz
           invoke pz "add-cheese" returning pz
           invoke pz "add-pepperoni" returning pz
           invoke pz "build" returning result-text

           display function trim(result-text)

           stop run.
       end program main.
