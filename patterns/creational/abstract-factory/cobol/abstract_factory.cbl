      *> Abstract Factory in Object-Oriented COBOL (GnuCOBOL).
      *> "light-factory" and "dark-factory" each create a whole FAMILY of
      *> matching widgets (button + checkbox) — "application" only talks
      *> to whichever factory it was given, never to the concrete widgets.
      *> Compile with:  cobc -x -free abstract_factory.cbl -o abstract_factory
       >>SOURCE FORMAT FREE
       identification division.
       class-id. light-button.
       object.
           procedure division.
           method-id. render.
               procedure division returning result as pic x(40).
                   move "[ Light Button ]" to result
               end method render.
       end object.
       end class light-button.

      *> ------------------------------------------------------------------
       identification division.
       class-id. light-checkbox.
       object.
           procedure division.
           method-id. render.
               procedure division returning result as pic x(40).
                   move "[x] Light Checkbox" to result
               end method render.
       end object.
       end class light-checkbox.

      *> ------------------------------------------------------------------
       identification division.
       class-id. dark-button.
       object.
           procedure division.
           method-id. render.
               procedure division returning result as pic x(40).
                   move "[ Dark Button ]" to result
               end method render.
       end object.
       end class dark-button.

      *> ------------------------------------------------------------------
       identification division.
       class-id. dark-checkbox.
       object.
           procedure division.
           method-id. render.
               procedure division returning result as pic x(40).
                   move "[x] Dark Checkbox" to result
               end method render.
       end object.
       end class dark-checkbox.

      *> ------------------------------------------------------------------
       identification division.
       class-id. light-factory.

       environment division.
       configuration section.
       repository.
           class light-button.
           class light-checkbox.

       object.
           procedure division.

           method-id. create-button.
               procedure division returning result as object reference.
                   invoke light-button "new" returning result
               end method create-button.

           method-id. create-checkbox.
               procedure division returning result as object reference.
                   invoke light-checkbox "new" returning result
               end method create-checkbox.

       end object.
       end class light-factory.

      *> ------------------------------------------------------------------
       identification division.
       class-id. dark-factory.

       environment division.
       configuration section.
       repository.
           class dark-button.
           class dark-checkbox.

       object.
           procedure division.

           method-id. create-button.
               procedure division returning result as object reference.
                   invoke dark-button "new" returning result
               end method create-button.

           method-id. create-checkbox.
               procedure division returning result as object reference.
                   invoke dark-checkbox "new" returning result
               end method create-checkbox.

       end object.
       end class dark-factory.

      *> ------------------------------------------------------------------
       identification division.
       class-id. application.

       object.
           working-storage section.
           01 the-button   object reference.
           01 the-checkbox object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 factory object reference.
               procedure division using factory.
                   invoke factory "create-button" returning the-button
                   invoke factory "create-checkbox" returning the-checkbox
               end method init.

           method-id. render.
               working-storage section.
               01 text pic x(40).
               procedure division.
                   invoke the-button "render" returning text
                   display function trim(text)
                   invoke the-checkbox "render" returning text
                   display function trim(text)
               end method render.

       end object.
       end class application.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class light-factory.
           class dark-factory.
           class application.

       data division.
       working-storage section.
       01 factory object reference.
       01 app     object reference.

       procedure division.
           invoke light-factory "new" returning factory
           invoke application "new" returning app
           invoke app "init" using factory
           invoke app "render"

           invoke dark-factory "new" returning factory
           invoke application "new" returning app
           invoke app "init" using factory
           invoke app "render"

           stop run.
       end program main.
