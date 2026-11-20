      *> Command in Object-Oriented COBOL (GnuCOBOL).
      *> "turn-on-command"/"turn-off-command" wrap an action on "light"
      *> as an object with "execute"/"undo" — "remote-control" only
      *> knows that interface, never what the command actually does.
      *> Compile with:  cobc -x -free command.cbl -o command
       >>SOURCE FORMAT FREE
       identification division.
       class-id. light.
       object.
           procedure division.
           method-id. turn-on.
               procedure division.
                   display "Light is ON"
               end method turn-on.
           method-id. turn-off.
               procedure division.
                   display "Light is OFF"
               end method turn-off.
       end object.
       end class light.

      *> ------------------------------------------------------------------
       identification division.
       class-id. turn-on-command.
       object.
           working-storage section.
           01 the-light object reference.
           procedure division.
           method-id. init.
               linkage section.
               01 light-in object reference.
               procedure division using light-in.
                   move light-in to the-light
               end method init.
           method-id. execute.
               procedure division.
                   invoke the-light "turn-on"
               end method execute.
           method-id. undo.
               procedure division.
                   invoke the-light "turn-off"
               end method undo.
       end object.
       end class turn-on-command.

      *> ------------------------------------------------------------------
       identification division.
       class-id. turn-off-command.
       object.
           working-storage section.
           01 the-light object reference.
           procedure division.
           method-id. init.
               linkage section.
               01 light-in object reference.
               procedure division using light-in.
                   move light-in to the-light
               end method init.
           method-id. execute.
               procedure division.
                   invoke the-light "turn-off"
               end method execute.
           method-id. undo.
               procedure division.
                   invoke the-light "turn-on"
               end method undo.
       end object.
       end class turn-off-command.

      *> ------------------------------------------------------------------
       identification division.
       class-id. remote-control.
       object.
           working-storage section.
           01 history-count pic 9(2) value 0.
           01 history-table.
               05 history-entry object reference occurs 20 times.

           procedure division.

           method-id. submit.
               linkage section.
               01 command object reference.
               procedure division using command.
                   invoke command "execute"
                   add 1 to history-count
                   move command to history-entry(history-count)
               end method submit.

           method-id. undo-last.
               working-storage section.
               01 last-command object reference.
               procedure division.
                   if history-count > 0
                       move history-entry(history-count) to last-command
                       subtract 1 from history-count
                       invoke last-command "undo"
                   end-if
               end method undo-last.

       end object.
       end class remote-control.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class light.
           class turn-on-command.
           class turn-off-command.
           class remote-control.

       data division.
       working-storage section.
       01 the-light  object reference.
       01 remote     object reference.
       01 on-cmd     object reference.
       01 off-cmd    object reference.

       procedure division.
           invoke light "new" returning the-light
           invoke remote-control "new" returning remote

           invoke turn-on-command "new" returning on-cmd
           invoke on-cmd "init" using the-light

           invoke turn-off-command "new" returning off-cmd
           invoke off-cmd "init" using the-light

           invoke remote "submit" using on-cmd
           invoke remote "submit" using off-cmd
           invoke remote "undo-last"
      *> undoes turn-off-command -> light turns back on

           stop run.
       end program main.
