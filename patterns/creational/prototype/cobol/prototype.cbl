      *> Prototype in Object-Oriented COBOL (GnuCOBOL).
      *> "sheep" knows how to clone itself — the caller gets a copy
      *> without knowing anything about the constructor or the class
      *> beyond "clone" itself.
      *> Compile with:  cobc -x -free prototype.cbl -o prototype
       >>SOURCE FORMAT FREE
       identification division.
       class-id. sheep.

       environment division.
       configuration section.
       repository.
           class sheep.

       object.
           working-storage section.
           01 the-name  pic x(20).
           01 the-color pic x(20).

           procedure division.

           method-id. init.
               linkage section.
               01 name-in  pic x(20).
               01 color-in pic x(20).
               procedure division using name-in color-in.
                   move name-in to the-name
                   move color-in to the-color
               end method init.

           method-id. set-name.
               linkage section.
               01 name-in pic x(20).
               procedure division using name-in.
                   move name-in to the-name
               end method set-name.

      *> shallow copy is enough here because every field is a plain
      *> alphanumeric value — a reference field would need deliberate
      *> copying too, or both sheep would end up sharing it.
           method-id. clone.
               working-storage section.
               01 copy object reference.
               procedure division returning result as object reference.
                   invoke sheep "new" returning copy
                   invoke copy "init" using the-name the-color
                   move copy to result
               end method clone.

           method-id. describe.
               procedure division returning result as pic x(60).
                   move spaces to result
                   string "Sheep(name=" delimited by size
                       function trim(the-name) delimited by size
                       ", color=" delimited by size
                       function trim(the-color) delimited by size
                       ")" delimited by size
                       into result
               end method describe.

       end object.
       end class sheep.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class sheep.

       data division.
       working-storage section.
       01 original object reference.
       01 the-clone object reference.
       01 text      pic x(60).

       procedure division.
           invoke sheep "new" returning original
           invoke original "init" using "Dolly" "white"

           invoke original "clone" returning the-clone
           invoke the-clone "set-name" using "Dolly Jr."

           invoke original "describe" returning text
           display function trim(text)

           invoke the-clone "describe" returning text
           display function trim(text)

           stop run.
       end program main.
