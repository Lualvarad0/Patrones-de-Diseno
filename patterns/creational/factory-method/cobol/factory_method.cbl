      *> Factory Method in Object-Oriented COBOL (GnuCOBOL).
      *> "document-creator" declares the factory method; "pdf-creator" and
      *> "word-creator" inherit from it and override it to decide which
      *> concrete document class gets instantiated.
      *> Compile with:  cobc -x -free factory_method.cbl -o factory_method
       >>SOURCE FORMAT FREE
       identification division.
       class-id. pdf-document.

       object.
           procedure division.

           method-id. render.
               procedure division returning result as pic x(40).
                   move "PDF document rendered" to result
               end method render.

       end object.
       end class pdf-document.

      *> ------------------------------------------------------------------
       identification division.
       class-id. word-document.

       object.
           procedure division.

           method-id. render.
               procedure division returning result as pic x(40).
                   move "Word document rendered" to result
               end method render.

       end object.
       end class word-document.

      *> ------------------------------------------------------------------
       identification division.
       class-id. document-creator.

       object.
           procedure division.

      *> The factory method: subclasses override this to pick the
      *> concrete document class. The base version returns null.
           method-id. create-document.
               procedure division returning result as object reference.
                   move null to result
               end method create-document.

      *> Uses the factory method without knowing which concrete
      *> document class "self" will actually produce.
           method-id. open.
               working-storage section.
               01 doc      object reference.
               01 the-text pic x(40).
               procedure division returning result as pic x(40).
                   invoke self "create-document" returning doc
                   invoke doc "render" returning the-text
                   move the-text to result
               end method open.

       end object.
       end class document-creator.

      *> ------------------------------------------------------------------
       identification division.
       class-id. pdf-creator inherits document-creator.

       environment division.
       configuration section.
       repository.
           class pdf-document.

       object.
           procedure division.

           method-id. create-document.
               procedure division returning result as object reference.
                   invoke pdf-document "new" returning result
               end method create-document.

       end object.
       end class pdf-creator.

      *> ------------------------------------------------------------------
       identification division.
       class-id. word-creator inherits document-creator.

       environment division.
       configuration section.
       repository.
           class word-document.

       object.
           procedure division.

           method-id. create-document.
               procedure division returning result as object reference.
                   invoke word-document "new" returning result
               end method create-document.

       end object.
       end class word-creator.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class pdf-creator.
           class word-creator.

       data division.
       working-storage section.
       01 creator  object reference.
       01 the-text pic x(40).

       procedure division.
           invoke pdf-creator "new" returning creator
           invoke creator "open" returning the-text
           display function trim(the-text)

           invoke word-creator "new" returning creator
           invoke creator "open" returning the-text
           display function trim(the-text)

           stop run.
       end program main.
