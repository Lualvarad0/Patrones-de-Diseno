      *> Flyweight in Object-Oriented COBOL (GnuCOBOL).
      *> "tree-factory" keeps one shared "tree-type" per distinct name —
      *> every "tree" only stores its own x/y plus a reference to the
      *> shared type, instead of duplicating the sprite data per tree.
      *> Compile with:  cobc -x -free flyweight.cbl -o flyweight
       >>SOURCE FORMAT FREE
       identification division.
       class-id. tree-type.

       object.
           working-storage section.
           01 the-name   pic x(10).
           01 the-sprite pic x(20).

           procedure division.

           method-id. init.
               linkage section.
               01 name-in   pic x(10).
               01 sprite-in pic x(20).
               procedure division using name-in sprite-in.
                   move name-in to the-name
                   move sprite-in to the-sprite
               end method init.

           method-id. get-name.
               procedure division returning result as pic x(10).
                   move the-name to result
               end method get-name.

           method-id. draw.
               linkage section.
               01 x-pos pic 9(3).
               01 y-pos pic 9(3).
               procedure division using x-pos y-pos.
                   display "Drawing " function trim(the-name) " ("
                       function trim(the-sprite) ") at (" x-pos "," y-pos ")"
               end method draw.

       end object.
       end class tree-type.

      *> ------------------------------------------------------------------
       identification division.
       class-id. tree-factory.

       environment division.
       configuration section.
       repository.
           class tree-type.

       object.
           working-storage section.
           01 type-count pic 9(2) value 0.
           01 type-table.
               05 type-entry object reference occurs 20 times.
           01 i pic 9(2).

           procedure division.

      *> linear search stands in for a hash map here — the point is
      *> that each distinct name only ever gets ONE tree-type instance
           method-id. get-tree-type.
               linkage section.
               01 name-in   pic x(10).
               01 sprite-in pic x(20).
               working-storage section.
               01 found     object reference.
               01 existing-name pic x(10).
               procedure division using name-in sprite-in
                       returning result as object reference.
                   move null to found
                   perform varying i from 1 by 1 until i > type-count
                       invoke type-entry(i) "get-name" returning existing-name
                       if existing-name = name-in
                           move type-entry(i) to found
                       end-if
                   end-perform

                   if found = null
                       invoke tree-type "new" returning found
                       invoke found "init" using name-in sprite-in
                       add 1 to type-count
                       move found to type-entry(type-count)
                       display "Created new TreeType: " function trim(name-in)
                   end-if

                   move found to result
               end method get-tree-type.

       end object.
       end class tree-factory.

      *> ------------------------------------------------------------------
       identification division.
       class-id. tree.

       object.
           working-storage section.
           01 x-pos    pic 9(3).
           01 y-pos    pic 9(3).
           01 the-type object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 x-in    pic 9(3).
               01 y-in    pic 9(3).
               01 type-in object reference.
               procedure division using x-in y-in type-in.
                   move x-in to x-pos
                   move y-in to y-pos
                   move type-in to the-type
               end method init.

           method-id. draw.
               procedure division.
                   invoke the-type "draw" using x-pos y-pos
               end method draw.

       end object.
       end class tree.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class tree-factory.
           class tree.

       data division.
       working-storage section.
       01 factory    object reference.
       01 pine-type  object reference.
       01 oak-type   object reference.
       01 tree-count pic 9(2) value 0.
       01 forest.
           05 forest-entry object reference occurs 10 times.
       01 i pic 9(2).
       01 t object reference.

       procedure division.
           invoke tree-factory "new" returning factory

           invoke factory "get-tree-type" using "Pine" "green-sprite"
               returning pine-type
           invoke tree "new" returning t
           invoke t "init" using 1 2 pine-type
           add 1 to tree-count
           move t to forest-entry(tree-count)

           invoke factory "get-tree-type" using "Pine" "green-sprite"
               returning pine-type
      *> same name -> reuses the tree-type created above, no "Created" message
           invoke tree "new" returning t
           invoke t "init" using 5 7 pine-type
           add 1 to tree-count
           move t to forest-entry(tree-count)

           invoke factory "get-tree-type" using "Oak" "brown-sprite"
               returning oak-type
           invoke tree "new" returning t
           invoke t "init" using 3 9 oak-type
           add 1 to tree-count
           move t to forest-entry(tree-count)

           perform varying i from 1 by 1 until i > tree-count
               invoke forest-entry(i) "draw"
           end-perform

           stop run.
       end program main.
