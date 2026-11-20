      *> Observer in Object-Oriented COBOL (GnuCOBOL).
      *> "weather-station" keeps a small table of subscribed observers
      *> and calls "update" on each one whenever the temperature changes.
      *> Compile with:  cobc -x -free observer.cbl -o observer
       >>SOURCE FORMAT FREE
       identification division.
       class-id. phone-display.

       object.
           procedure division.

           method-id. update.
               linkage section.
               01 temperature pic 9(3)v9.
               procedure division using temperature.
                   display "[Phone] Temperature is now " temperature "C"
               end method update.

       end object.
       end class phone-display.

      *> ------------------------------------------------------------------
       identification division.
       class-id. tv-display.

       object.
           procedure division.

           method-id. update.
               linkage section.
               01 temperature pic 9(3)v9.
               procedure division using temperature.
                   display "[TV] Temperature is now " temperature "C"
               end method update.

       end object.
       end class tv-display.

      *> ------------------------------------------------------------------
       identification division.
       class-id. weather-station.

       object.
           working-storage section.
           01 observer-count pic 9(2) value 0.
           01 observer-table.
               05 observer-entry object reference occurs 10 times.
           01 i pic 9(2).

           procedure division.

           method-id. subscribe.
               linkage section.
               01 obs object reference.
               procedure division using obs.
                   add 1 to observer-count
                   move obs to observer-entry(observer-count)
               end method subscribe.

      *> marks the matching slot as empty instead of shrinking the
      *> table, so the indices of the other observers stay stable.
           method-id. unsubscribe.
               linkage section.
               01 obs object reference.
               procedure division using obs.
                   perform varying i from 1 by 1 until i > observer-count
                       if observer-entry(i) = obs
                           move null to observer-entry(i)
                       end-if
                   end-perform
               end method unsubscribe.

           method-id. set-temperature.
               linkage section.
               01 temperature pic 9(3)v9.
               procedure division using temperature.
                   perform varying i from 1 by 1 until i > observer-count
                       if observer-entry(i) not = null
                           invoke observer-entry(i) "update" using temperature
                       end-if
                   end-perform
               end method set-temperature.

       end object.
       end class weather-station.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class phone-display.
           class tv-display.
           class weather-station.

       data division.
       working-storage section.
       01 station object reference.
       01 phone   object reference.
       01 tv      object reference.

       procedure division.
           invoke phone-display "new" returning phone
           invoke tv-display "new" returning tv
           invoke weather-station "new" returning station

           invoke station "subscribe" using phone
           invoke station "subscribe" using tv

           invoke station "set-temperature" using 23.5
      *> both observers get notified

           invoke station "unsubscribe" using tv
           invoke station "set-temperature" using 24.0
      *> only phone gets notified now

           stop run.
       end program main.
