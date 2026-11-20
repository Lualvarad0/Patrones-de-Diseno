      *> Interpreter in Object-Oriented COBOL (GnuCOBOL).
      *> A tiny arithmetic grammar as a tree of objects — each node's
      *> "interpret" method evaluates itself, recursing into its
      *> children, so evaluating the root evaluates the whole expression.
      *> Compile with:  cobc -x -free interpreter.cbl -o interpreter
       >>SOURCE FORMAT FREE
       identification division.
       class-id. number-expression.
       object.
           working-storage section.
           01 the-value pic s9(5).
           procedure division.
           method-id. init.
               linkage section.
               01 value-in pic s9(5).
               procedure division using value-in.
                   move value-in to the-value
               end method init.
           method-id. interpret.
               procedure division returning result as pic s9(5).
                   move the-value to result
               end method interpret.
       end object.
       end class number-expression.

      *> ------------------------------------------------------------------
       identification division.
       class-id. add-expression.
       object.
           working-storage section.
           01 left-exp  object reference.
           01 right-exp object reference.
           procedure division.
           method-id. init.
               linkage section.
               01 left-in  object reference.
               01 right-in object reference.
               procedure division using left-in right-in.
                   move left-in to left-exp
                   move right-in to right-exp
               end method init.
           method-id. interpret.
               working-storage section.
               01 left-val  pic s9(5).
               01 right-val pic s9(5).
               procedure division returning result as pic s9(5).
                   invoke left-exp "interpret" returning left-val
                   invoke right-exp "interpret" returning right-val
                   compute result = left-val + right-val
               end method interpret.
       end object.
       end class add-expression.

      *> ------------------------------------------------------------------
       identification division.
       class-id. subtract-expression.
       object.
           working-storage section.
           01 left-exp  object reference.
           01 right-exp object reference.
           procedure division.
           method-id. init.
               linkage section.
               01 left-in  object reference.
               01 right-in object reference.
               procedure division using left-in right-in.
                   move left-in to left-exp
                   move right-in to right-exp
               end method init.
           method-id. interpret.
               working-storage section.
               01 left-val  pic s9(5).
               01 right-val pic s9(5).
               procedure division returning result as pic s9(5).
                   invoke left-exp "interpret" returning left-val
                   invoke right-exp "interpret" returning right-val
                   compute result = left-val - right-val
               end method interpret.
       end object.
       end class subtract-expression.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class number-expression.
           class add-expression.
           class subtract-expression.

       data division.
       working-storage section.
       01 five        object reference.
       01 three       object reference.
       01 two         object reference.
       01 add-node    object reference.
       01 sub-node    object reference.
       01 final-value pic s9(5).

       procedure division.
      *> builds the tree for (5 + 3) - 2
           invoke number-expression "new" returning five
           invoke five "init" using 5

           invoke number-expression "new" returning three
           invoke three "init" using 3

           invoke number-expression "new" returning two
           invoke two "init" using 2

           invoke add-expression "new" returning add-node
           invoke add-node "init" using five three

           invoke subtract-expression "new" returning sub-node
           invoke sub-node "init" using add-node two

           invoke sub-node "interpret" returning final-value
           display "(5 + 3) - 2 = " final-value

           stop run.
       end program main.
