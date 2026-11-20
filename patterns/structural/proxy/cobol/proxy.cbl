      *> Proxy in Object-Oriented COBOL (GnuCOBOL).
      *> "image-proxy" exposes the same "display" method as "real-image"
      *> but only creates the (expensive) real-image the first time
      *> display is actually called — a "virtual proxy".
      *> Compile with:  cobc -x -free proxy.cbl -o proxy
       >>SOURCE FORMAT FREE
       identification division.
       class-id. real-image.

       object.
           working-storage section.
           01 the-filename pic x(20).

           procedure division.

      *> expensive to create — simulates loading from disk
           method-id. init.
               linkage section.
               01 filename-in pic x(20).
               procedure division using filename-in.
                   move filename-in to the-filename
                   display "Loading " function trim(the-filename)
                       " from disk..."
               end method init.

           method-id. display.
               procedure division.
                   display "Displaying " function trim(the-filename)
               end method display.

       end object.
       end class real-image.

      *> ------------------------------------------------------------------
       identification division.
       class-id. image-proxy.

       environment division.
       configuration section.
       repository.
           class real-image.

       object.
           working-storage section.
           01 the-filename pic x(20).
           01 the-real-image object reference value null.

           procedure division.

           method-id. init.
               linkage section.
               01 filename-in pic x(20).
               procedure division using filename-in.
                   move filename-in to the-filename
               end method init.

           method-id. display.
               procedure division.
                   if the-real-image = null
                       invoke real-image "new" returning the-real-image
                       invoke the-real-image "init" using the-filename
                   end-if
                   invoke the-real-image "display"
               end method display.

       end object.
       end class image-proxy.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class image-proxy.

       data division.
       working-storage section.
       01 image object reference.

       procedure division.
           invoke image-proxy "new" returning image
           invoke image "init" using "photo.png"

           display "Image proxy created, nothing loaded yet"
           invoke image "display"
      *> loads from disk here
           invoke image "display"
      *> reuses the already-loaded real-image

           stop run.
       end program main.
