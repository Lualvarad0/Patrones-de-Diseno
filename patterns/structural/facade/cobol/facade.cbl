      *> Facade in Object-Oriented COBOL (GnuCOBOL).
      *> "home-theater-facade" hides amplifier/dvd-player/projector
      *> behind one simple "watch-movie" call — the three classes still
      *> exist and could be driven directly by anyone who needs the detail.
      *> Compile with:  cobc -x -free facade.cbl -o facade
       >>SOURCE FORMAT FREE
       identification division.
       class-id. amplifier.
       object.
           procedure division.
           method-id. on.
               procedure division.
                   display "Amplifier on"
               end method on.
           method-id. set-volume.
               linkage section.
               01 level pic 9(2).
               procedure division using level.
                   display "Amplifier volume set to " level
               end method set-volume.
           method-id. off.
               procedure division.
                   display "Amplifier off"
               end method off.
       end object.
       end class amplifier.

      *> ------------------------------------------------------------------
       identification division.
       class-id. dvd-player.
       object.
           procedure division.
           method-id. on.
               procedure division.
                   display "DVD player on"
               end method on.
           method-id. play.
               linkage section.
               01 movie pic x(30).
               procedure division using movie.
                   display "Playing " function trim(movie)
               end method play.
           method-id. off.
               procedure division.
                   display "DVD player off"
               end method off.
       end object.
       end class dvd-player.

      *> ------------------------------------------------------------------
       identification division.
       class-id. projector.
       object.
           procedure division.
           method-id. on.
               procedure division.
                   display "Projector on"
               end method on.
           method-id. set-input.
               linkage section.
               01 source pic x(10).
               procedure division using source.
                   display "Projector input set to " function trim(source)
               end method set-input.
           method-id. off.
               procedure division.
                   display "Projector off"
               end method off.
       end object.
       end class projector.

      *> ------------------------------------------------------------------
       identification division.
       class-id. home-theater-facade.

       environment division.
       configuration section.
       repository.
           class amplifier.
           class dvd-player.
           class projector.

       object.
           working-storage section.
           01 the-amplifier object reference.
           01 the-dvd       object reference.
           01 the-projector object reference.

           procedure division.

           method-id. init.
               procedure division.
                   invoke amplifier "new" returning the-amplifier
                   invoke dvd-player "new" returning the-dvd
                   invoke projector "new" returning the-projector
               end method init.

           method-id. watch-movie.
               linkage section.
               01 movie pic x(30).
               procedure division using movie.
                   invoke the-amplifier "on"
                   invoke the-amplifier "set-volume" using 7
                   invoke the-projector "on"
                   invoke the-projector "set-input" using "DVD"
                   invoke the-dvd "on"
                   invoke the-dvd "play" using movie
               end method watch-movie.

           method-id. end-movie.
               procedure division.
                   invoke the-dvd "off"
                   invoke the-projector "off"
                   invoke the-amplifier "off"
               end method end-movie.

       end object.
       end class home-theater-facade.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class home-theater-facade.

       data division.
       working-storage section.
       01 home-theater object reference.

       procedure division.
           invoke home-theater-facade "new" returning home-theater
           invoke home-theater "init"
           invoke home-theater "watch-movie" using "The Matrix"
      *> one call instead of six
           invoke home-theater "end-movie"

           stop run.
       end program main.
