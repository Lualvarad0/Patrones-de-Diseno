      *> Adapter in Object-Oriented COBOL (GnuCOBOL).
      *> "rectangle-adapter" exposes the "draw" method our client expects,
      *> and translates it into the call "legacy-rectangle" actually
      *> understands ("old-draw" with four separate coordinates).
      *> Compile with:  cobc -x -free adapter.cbl -o adapter
       >>SOURCE FORMAT FREE
       identification division.
       class-id. legacy-rectangle.

       object.
           procedure division.

           method-id. old-draw.
               linkage section.
               01 x1 pic 9(4).
               01 y1 pic 9(4).
               01 x2 pic 9(4).
               01 y2 pic 9(4).
               procedure division using x1 y1 x2 y2.
                   display "LegacyRectangle drawn from (" x1 "," y1
                       ") to (" x2 "," y2 ")"
               end method old-draw.

       end object.
       end class legacy-rectangle.

      *> ------------------------------------------------------------------
       identification division.
       class-id. rectangle-adapter.

       environment division.
       configuration section.
       repository.
           class legacy-rectangle.

       object.
           working-storage section.
           01 stored-x1     pic 9(4).
           01 stored-y1     pic 9(4).
           01 stored-x2     pic 9(4).
           01 stored-y2     pic 9(4).
           01 stored-legacy object reference.

           procedure division.

      *> stores everything draw() will need to delegate to the legacy type
           method-id. init.
               linkage section.
               01 legacy object reference.
               01 x1 pic 9(4).
               01 y1 pic 9(4).
               01 x2 pic 9(4).
               01 y2 pic 9(4).
               procedure division using legacy x1 y1 x2 y2.
                   move legacy to stored-legacy
                   move x1 to stored-x1
                   move y1 to stored-y1
                   move x2 to stored-x2
                   move y2 to stored-y2
               end method init.

      *> the interface our client code expects
           method-id. draw.
               procedure division.
                   invoke stored-legacy "old-draw"
                       using stored-x1 stored-y1 stored-x2 stored-y2
               end method draw.

       end object.
       end class rectangle-adapter.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class legacy-rectangle.
           class rectangle-adapter.

       data division.
       working-storage section.
       01 legacy  object reference.
       01 shape   object reference.

       procedure division.
           invoke legacy-rectangle "new" returning legacy
           invoke rectangle-adapter "new" returning shape
           invoke shape "init" using legacy 0 0 10 20

           invoke shape "draw" *> client only ever talks to draw()

           stop run.
       end program main.
