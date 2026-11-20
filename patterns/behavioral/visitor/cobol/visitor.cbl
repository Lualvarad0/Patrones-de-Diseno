      *> Visitor in Object-Oriented COBOL (GnuCOBOL).
      *> New operations on the stable shape hierarchy (circle, square)
      *> live in separate visitor classes instead of being added as a
      *> method to every shape. Double dispatch: "accept" calls the
      *> visitor's "visit-circle"/"visit-square", passing itself, so the
      *> visitor knows the concrete shape type without any type check.
      *> Compile with:  cobc -x -free visitor.cbl -o visitor
       >>SOURCE FORMAT FREE
       identification division.
       class-id. circle.

       object.
           01 radius usage float-long.

           procedure division.

           method-id. set-radius.
               procedure division using by value r.
               01 r usage float-long.
               set radius to r
               end method set-radius.

           method-id. get-radius.
               procedure division returning r.
               01 r usage float-long.
               set r to radius
               end method get-radius.

           method-id. accept.
               procedure division using by value visitor.
               01 visitor object reference.
                   invoke visitor "visit-circle" using self
               end method accept.

       end object.
       end class circle.

      *> ------------------------------------------------------------------
       identification division.
       class-id. square.

       object.
           01 side usage float-long.

           procedure division.

           method-id. set-side.
               procedure division using by value s.
               01 s usage float-long.
               set side to s
               end method set-side.

           method-id. get-side.
               procedure division returning s.
               01 s usage float-long.
               set s to side
               end method get-side.

           method-id. accept.
               procedure division using by value visitor.
               01 visitor object reference.
                   invoke visitor "visit-square" using self
               end method accept.

       end object.
       end class square.

      *> ------------------------------------------------------------------
       identification division.
       class-id. area-visitor.
       environment division.
       configuration section.
       repository.
           class circle
           class square.

       object.
           procedure division.

           method-id. visit-circle.
               procedure division using by value shape.
               01 shape object reference.
               working-storage section.
               01 r usage float-long.
               01 area usage float-long.
               procedure division.
                   invoke shape "get-radius" returning r
                   compute area = 3.14159265358979 * r * r
                   display "Circle area: " area
               end method visit-circle.

           method-id. visit-square.
               procedure division using by value shape.
               01 shape object reference.
               working-storage section.
               01 s usage float-long.
               01 area usage float-long.
               procedure division.
                   invoke shape "get-side" returning s
                   compute area = s * s
                   display "Square area: " area
               end method visit-square.

       end object.
       end class area-visitor.

      *> ------------------------------------------------------------------
       identification division.
       class-id. svg-export-visitor.
       environment division.
       configuration section.
       repository.
           class circle
           class square.

       object.
           procedure division.

           method-id. visit-circle.
               procedure division using by value shape.
               01 shape object reference.
               working-storage section.
               01 r usage float-long.
               procedure division.
                   invoke shape "get-radius" returning r
                   display "<circle r=""" r """ />"
               end method visit-circle.

           method-id. visit-square.
               procedure division using by value shape.
               01 shape object reference.
               working-storage section.
               01 s usage float-long.
               procedure division.
                   invoke shape "get-side" returning s
                   display "<rect width=""" s """ height=""" s """ />"
               end method visit-square.

       end object.
       end class svg-export-visitor.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class circle
           class square
           class area-visitor
           class svg-export-visitor.

       data division.
       working-storage section.
       01 a-circle object reference.
       01 a-square object reference.
       01 area-v object reference.
       01 svg-v object reference.

       procedure division.
           invoke circle "new" returning a-circle
           invoke a-circle "set-radius" using 3.0

           invoke square "new" returning a-square
           invoke a-square "set-side" using 4.0

           invoke area-visitor "new" returning area-v
           invoke a-circle "accept" using area-v
           invoke a-square "accept" using area-v
      *> same shapes, area operation

           display " "

           invoke svg-export-visitor "new" returning svg-v
           invoke a-circle "accept" using svg-v
           invoke a-square "accept" using svg-v
      *> same shapes, export operation

           stop run.
       end program main.
