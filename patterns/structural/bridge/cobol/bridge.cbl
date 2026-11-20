      *> Bridge in Object-Oriented COBOL (GnuCOBOL).
      *> "remote-control" (the abstraction) holds a device object
      *> reference and delegates to it, never knowing the concrete device
      *> class — the two hierarchies (remotes, devices) grow independently.
      *> Compile with:  cobc -x -free bridge.cbl -o bridge
       >>SOURCE FORMAT FREE
       identification division.
       class-id. tv.

       object.
           working-storage section.
           01 on-flag pic 9 value 0.

           procedure division.

           method-id. turn-on.
               procedure division.
                   move 1 to on-flag
               end method turn-on.

           method-id. turn-off.
               procedure division.
                   move 0 to on-flag
               end method turn-off.

           method-id. is-on.
               procedure division returning result as pic 9.
                   move on-flag to result
               end method is-on.

           method-id. get-name.
               procedure division returning result as pic x(10).
                   move "TV" to result
               end method get-name.

       end object.
       end class tv.

      *> ------------------------------------------------------------------
       identification division.
       class-id. radio.

       object.
           working-storage section.
           01 on-flag pic 9 value 0.

           procedure division.

           method-id. turn-on.
               procedure division.
                   move 1 to on-flag
               end method turn-on.

           method-id. turn-off.
               procedure division.
                   move 0 to on-flag
               end method turn-off.

           method-id. is-on.
               procedure division returning result as pic 9.
                   move on-flag to result
               end method is-on.

           method-id. get-name.
               procedure division returning result as pic x(10).
                   move "Radio" to result
               end method get-name.

       end object.
       end class radio.

      *> ------------------------------------------------------------------
       identification division.
       class-id. remote-control.

       object.
           working-storage section.
           01 device object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 device-in object reference.
               procedure division using device-in.
                   move device-in to device
               end method init.

      *> lets subclasses reach the device without exposing the field itself
           method-id. get-device.
               procedure division returning result as object reference.
                   move device to result
               end method get-device.

           method-id. toggle-power.
               working-storage section.
               01 is-on-flag pic 9.
               01 the-name   pic x(10).
               procedure division.
                   invoke device "is-on" returning is-on-flag
                   if is-on-flag = 1
                       invoke device "turn-off"
                   else
                       invoke device "turn-on"
                   end-if
                   invoke device "is-on" returning is-on-flag
                   invoke device "get-name" returning the-name
                   if is-on-flag = 1
                       display function trim(the-name) " is now ON"
                   else
                       display function trim(the-name) " is now OFF"
                   end-if
               end method toggle-power.

       end object.
       end class remote-control.

      *> ------------------------------------------------------------------
       identification division.
       class-id. advanced-remote-control inherits remote-control.

       object.
           procedure division.

           method-id. mute.
               working-storage section.
               01 dev        object reference.
               01 is-on-flag pic 9.
               01 the-name   pic x(10).
               procedure division.
                   invoke self "get-device" returning dev
                   invoke dev "is-on" returning is-on-flag
                   if is-on-flag = 1
                       invoke dev "get-name" returning the-name
                       display function trim(the-name) " muted"
                   end-if
               end method mute.

       end object.
       end class advanced-remote-control.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class tv.
           class radio.
           class remote-control.
           class advanced-remote-control.

       data division.
       working-storage section.
       01 tv-device    object reference.
       01 radio-device object reference.
       01 tv-remote    object reference.
       01 radio-remote object reference.

       procedure division.
           invoke tv "new" returning tv-device
           invoke remote-control "new" returning tv-remote
           invoke tv-remote "init" using tv-device
           invoke tv-remote "toggle-power"

           invoke radio "new" returning radio-device
           invoke advanced-remote-control "new" returning radio-remote
           invoke radio-remote "init" using radio-device
           invoke radio-remote "toggle-power"
           invoke radio-remote "mute"

           stop run.
       end program main.
