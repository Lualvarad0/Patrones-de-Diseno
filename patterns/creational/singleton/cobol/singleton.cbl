      *> Singleton in Object-Oriented COBOL (GnuCOBOL).
      *> The FACTORY section holds class-level (static) storage — that is
      *> exactly where the one-and-only shared instance lives.
      *> Compile with:  cobc -x -free singleton.cbl -o singleton
       >>SOURCE FORMAT FREE
       identification division.
       class-id. logger.

       environment division.
       configuration section.
       repository.
           class logger.

       factory.
           working-storage section.
           01 the-instance object reference value null.

           procedure division.

           method-id. instance.
               procedure division returning result as object reference.
                   if the-instance = null
                       invoke logger "new" returning the-instance
                   end-if
                   move the-instance to result
               end method instance.

       end factory.

       object.
           working-storage section.
           01 message-count pic 9(4) value 0.

           procedure division.

           method-id. log.
               linkage section.
               01 message pic x(80).
               procedure division using message.
                   add 1 to message-count
                   display "[" message-count "] " function trim(message)
               end method log.

       end object.

       end class logger.

       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class logger.

       data division.
       working-storage section.
       01 logger-ref      object reference.
       01 same-logger-ref object reference.

       procedure division.
           invoke logger "instance" returning logger-ref
           invoke logger-ref "log" using "App started"

           invoke logger "instance" returning same-logger-ref
           invoke same-logger-ref "log" using "Second message, same instance"

           if logger-ref = same-logger-ref
               display "Same instance confirmed"
           else
               display "BUG: different instances"
           end-if

           stop run.
       end program main.
