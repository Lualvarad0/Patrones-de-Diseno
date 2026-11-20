      *> State in Object-Oriented COBOL (GnuCOBOL).
      *> "traffic-light" holds its current state object and delegates
      *> to it — each state class decides what the NEXT state is.
      *> Compile with:  cobc -x -free state.cbl -o state
       >>SOURCE FORMAT FREE
       identification division.
       class-id. red-state.

       environment division.
       configuration section.
       repository.
           class green-state.

       object.
           procedure division.
           method-id. next.
               linkage section.
               01 light object reference.
               working-storage section.
               01 new-state object reference.
               procedure division using light.
                   invoke green-state "new" returning new-state
                   invoke light "set-state" using new-state
               end method next.
           method-id. get-name.
               procedure division returning result as pic x(10).
                   move "Red" to result
               end method get-name.
       end object.
       end class red-state.

      *> ------------------------------------------------------------------
       identification division.
       class-id. green-state.

       environment division.
       configuration section.
       repository.
           class yellow-state.

       object.
           procedure division.
           method-id. next.
               linkage section.
               01 light object reference.
               working-storage section.
               01 new-state object reference.
               procedure division using light.
                   invoke yellow-state "new" returning new-state
                   invoke light "set-state" using new-state
               end method next.
           method-id. get-name.
               procedure division returning result as pic x(10).
                   move "Green" to result
               end method get-name.
       end object.
       end class green-state.

      *> ------------------------------------------------------------------
       identification division.
       class-id. yellow-state.

       environment division.
       configuration section.
       repository.
           class red-state.

       object.
           procedure division.
           method-id. next.
               linkage section.
               01 light object reference.
               working-storage section.
               01 new-state object reference.
               procedure division using light.
                   invoke red-state "new" returning new-state
                   invoke light "set-state" using new-state
               end method next.
           method-id. get-name.
               procedure division returning result as pic x(10).
                   move "Yellow" to result
               end method get-name.
       end object.
       end class yellow-state.

      *> ------------------------------------------------------------------
       identification division.
       class-id. traffic-light.

       environment division.
       configuration section.
       repository.
           class red-state.

       object.
           working-storage section.
           01 current-state object reference.

           procedure division.

           method-id. init.
               procedure division.
                   invoke red-state "new" returning current-state
               end method init.

           method-id. set-state.
               linkage section.
               01 state-in object reference.
               procedure division using state-in.
                   move state-in to current-state
               end method set-state.

           method-id. change.
               working-storage section.
               01 light-name pic x(10).
               procedure division.
                   invoke current-state "next" using self
                   invoke current-state "get-name" returning light-name
                   display "Light is now " function trim(light-name)
               end method change.

       end object.
       end class traffic-light.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class traffic-light.

       data division.
       working-storage section.
       01 light object reference.

       procedure division.
           invoke traffic-light "new" returning light
           invoke light "init"

           invoke light "change"
      *> Red -> Green
           invoke light "change"
      *> Green -> Yellow
           invoke light "change"
      *> Yellow -> Red

           stop run.
       end program main.
