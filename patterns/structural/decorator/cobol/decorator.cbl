      *> Decorator in Object-Oriented COBOL (GnuCOBOL).
      *> "milk-decorator" and "sugar-decorator" wrap any object that
      *> responds to "description"/"cost" and add their own bit on top —
      *> they can be stacked in any order and any combination.
      *> Compile with:  cobc -x -free decorator.cbl -o decorator
       >>SOURCE FORMAT FREE
       identification division.
       class-id. simple-coffee.

       object.
           procedure division.

           method-id. description.
               procedure division returning result as pic x(40).
                   move "Coffee" to result
               end method description.

           method-id. cost.
               procedure division returning result as pic 9(3)v99.
                   move 2.00 to result
               end method cost.

       end object.
       end class simple-coffee.

      *> ------------------------------------------------------------------
       identification division.
       class-id. milk-decorator.

       object.
           working-storage section.
           01 wrapped object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 beverage object reference.
               procedure division using beverage.
                   move beverage to wrapped
               end method init.

           method-id. description.
               working-storage section.
               01 inner-text pic x(40).
               procedure division returning result as pic x(40).
                   invoke wrapped "description" returning inner-text
                   move spaces to result
                   string function trim(inner-text) delimited by size
                       " + Milk" delimited by size
                       into result
               end method description.

           method-id. cost.
               working-storage section.
               01 inner-cost pic 9(3)v99.
               procedure division returning result as pic 9(3)v99.
                   invoke wrapped "cost" returning inner-cost
                   compute result = inner-cost + 0.50
               end method cost.

       end object.
       end class milk-decorator.

      *> ------------------------------------------------------------------
       identification division.
       class-id. sugar-decorator.

       object.
           working-storage section.
           01 wrapped object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 beverage object reference.
               procedure division using beverage.
                   move beverage to wrapped
               end method init.

           method-id. description.
               working-storage section.
               01 inner-text pic x(40).
               procedure division returning result as pic x(40).
                   invoke wrapped "description" returning inner-text
                   move spaces to result
                   string function trim(inner-text) delimited by size
                       " + Sugar" delimited by size
                       into result
               end method description.

           method-id. cost.
               working-storage section.
               01 inner-cost pic 9(3)v99.
               procedure division returning result as pic 9(3)v99.
                   invoke wrapped "cost" returning inner-cost
                   compute result = inner-cost + 0.20
               end method cost.

       end object.
       end class sugar-decorator.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class simple-coffee.
           class milk-decorator.
           class sugar-decorator.

       data division.
       working-storage section.
       01 coffee       object reference.
       01 with-milk    object reference.
       01 with-sugar   object reference.
       01 final-text   pic x(40).
       01 final-cost   pic 9(3)v99.

       procedure division.
      *> build the stack: coffee -> milk -> sugar, then read the
      *> result only from the outermost wrapper (with-sugar).
           invoke simple-coffee "new" returning coffee

           invoke milk-decorator "new" returning with-milk
           invoke with-milk "init" using coffee

           invoke sugar-decorator "new" returning with-sugar
           invoke with-sugar "init" using with-milk

           invoke with-sugar "description" returning final-text
           invoke with-sugar "cost" returning final-cost

           display function trim(final-text) " => $" final-cost

           stop run.
       end program main.
