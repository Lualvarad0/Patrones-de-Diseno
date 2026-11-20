      *> Chain of Responsibility in Object-Oriented COBOL (GnuCOBOL).
      *> "support-handler" implements the generic "handle" logic once;
      *> "level1/2/3-support" inherit it and only override "can-handle"
      *> and "resolve" — each either resolves the request or passes it
      *> down the chain.
      *> Compile with:  cobc -x -free chain_of_responsibility.cbl -o chain_of_responsibility
       >>SOURCE FORMAT FREE
       identification division.
       class-id. support-handler.

       object.
           working-storage section.
           01 next-handler object reference value null.

           procedure division.

           method-id. set-next.
               linkage section.
               01 next-in object reference.
               procedure division using next-in returning result as object reference.
                   move next-in to next-handler
                   move next-in to result
               end method set-next.

      *> overridden by each level — base version handles nothing
           method-id. can-handle.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity returning result as pic 9.
                   move 0 to result
               end method can-handle.

           method-id. resolve.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity.
                   continue
               end method resolve.

           method-id. handle.
               linkage section.
               01 severity pic 9(2).
               working-storage section.
               01 can-flag pic 9.
               procedure division using severity.
                   invoke self "can-handle" using severity returning can-flag
                   if can-flag = 1
                       invoke self "resolve" using severity
                   else
                       if next-handler not = null
                           invoke next-handler "handle" using severity
                       else
                           display "No handler could resolve severity " severity
                       end-if
                   end-if
               end method handle.

       end object.
       end class support-handler.

      *> ------------------------------------------------------------------
       identification division.
       class-id. level1-support inherits support-handler.
       object.
           procedure division.
           method-id. can-handle.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity returning result as pic 9.
                   if severity <= 1
                       move 1 to result
                   else
                       move 0 to result
                   end-if
               end method can-handle.
           method-id. resolve.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity.
                   display "Level1 resolved severity " severity
               end method resolve.
       end object.
       end class level1-support.

      *> ------------------------------------------------------------------
       identification division.
       class-id. level2-support inherits support-handler.
       object.
           procedure division.
           method-id. can-handle.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity returning result as pic 9.
                   if severity <= 2
                       move 1 to result
                   else
                       move 0 to result
                   end-if
               end method can-handle.
           method-id. resolve.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity.
                   display "Level2 resolved severity " severity
               end method resolve.
       end object.
       end class level2-support.

      *> ------------------------------------------------------------------
       identification division.
       class-id. level3-support inherits support-handler.
       object.
           procedure division.
           method-id. can-handle.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity returning result as pic 9.
                   if severity <= 3
                       move 1 to result
                   else
                       move 0 to result
                   end-if
               end method can-handle.
           method-id. resolve.
               linkage section.
               01 severity pic 9(2).
               procedure division using severity.
                   display "Level3 resolved severity " severity
               end method resolve.
       end object.
       end class level3-support.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class level1-support.
           class level2-support.
           class level3-support.

       data division.
       working-storage section.
       01 level1 object reference.
       01 level2 object reference.
       01 level3 object reference.
       01 unused object reference.

       procedure division.
           invoke level1-support "new" returning level1
           invoke level2-support "new" returning level2
           invoke level3-support "new" returning level3

           invoke level1 "set-next" using level2 returning unused
           invoke level2 "set-next" using level3 returning unused
      *> chain: 1 -> 2 -> 3

           invoke level1 "handle" using 1
           invoke level1 "handle" using 2
           invoke level1 "handle" using 3
           invoke level1 "handle" using 5

           stop run.
       end program main.
