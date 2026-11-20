      *> Memento in Object-Oriented COBOL (GnuCOBOL).
      *> "text-editor" saves a snapshot of its own content into an
      *> opaque "editor-memento" — "history" just stores and returns
      *> those objects, never looking inside them.
      *> Compile with:  cobc -x -free memento.cbl -o memento
       >>SOURCE FORMAT FREE
       identification division.
       class-id. editor-memento.

      *> the snapshot: immutable once created, opaque to everyone but
      *> the editor
       object.
           working-storage section.
           01 the-content pic x(60).

           procedure division.

           method-id. init.
               linkage section.
               01 content-in pic x(60).
               procedure division using content-in.
                   move content-in to the-content
               end method init.

           method-id. get-content.
               procedure division returning result as pic x(60).
                   move the-content to result
               end method get-content.

       end object.
       end class editor-memento.

      *> ------------------------------------------------------------------
       identification division.
       class-id. text-editor.

       environment division.
       configuration section.
       repository.
           class editor-memento.

       object.
           working-storage section.
           01 the-content pic x(60) value spaces.

           procedure division.

           method-id. type-text.
               linkage section.
               01 text-in pic x(60).
               working-storage section.
               01 combined pic x(60).
               procedure division using text-in.
                   move spaces to combined
                   string function trim(the-content) delimited by size
                       function trim(text-in) delimited by size
                       into combined
                   move combined to the-content
               end method type-text.

           method-id. get-content.
               procedure division returning result as pic x(60).
                   move the-content to result
               end method get-content.

           method-id. save.
               working-storage section.
               01 snapshot object reference.
               procedure division returning result as object reference.
                   invoke editor-memento "new" returning snapshot
                   invoke snapshot "init" using the-content
                   move snapshot to result
               end method save.

           method-id. restore.
               linkage section.
               01 memento object reference.
               procedure division using memento.
                   invoke memento "get-content" returning the-content
               end method restore.

       end object.
       end class text-editor.

      *> ------------------------------------------------------------------
       identification division.
       class-id. history.

      *> the "caretaker": stores snapshots but never looks inside them
       object.
           working-storage section.
           01 snapshot-count pic 9(2) value 0.
           01 snapshot-table.
               05 snapshot-entry object reference occurs 10 times.

           procedure division.

           method-id. push.
               linkage section.
               01 memento object reference.
               procedure division using memento.
                   add 1 to snapshot-count
                   move memento to snapshot-entry(snapshot-count)
               end method push.

           method-id. pop.
               procedure division returning result as object reference.
                   move snapshot-entry(snapshot-count) to result
                   subtract 1 from snapshot-count
               end method pop.

       end object.
       end class history.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class text-editor.
           class history.

       data division.
       working-storage section.
       01 editor    object reference.
       01 the-history object reference.
       01 snapshot  object reference.
       01 text      pic x(60).

       procedure division.
           invoke text-editor "new" returning editor
           invoke history "new" returning the-history

           invoke editor "type-text" using "Hello"
           invoke editor "save" returning snapshot
           invoke the-history "push" using snapshot
      *> checkpoint 1: "Hello"

           invoke editor "type-text" using ", world!"
           invoke editor "save" returning snapshot
           invoke the-history "push" using snapshot
      *> checkpoint 2: "Hello, world!"

           invoke editor "type-text" using " This part is a typo."
           invoke editor "get-content" returning text
           display "Before undo: " function trim(text)

           invoke the-history "pop" returning snapshot
           invoke editor "restore" using snapshot
      *> undo back to checkpoint 2
           invoke editor "get-content" returning text
           display "After undo: " function trim(text)

           stop run.
       end program main.
