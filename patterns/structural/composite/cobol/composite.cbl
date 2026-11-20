      *> Composite in Object-Oriented COBOL (GnuCOBOL).
      *> "file-item" (leaf) and "folder" (container) both respond to
      *> "get-size" and "print" — the client never has to ask which one
      *> it is holding.
      *> Compile with:  cobc -x -free composite.cbl -o composite
       >>SOURCE FORMAT FREE
       identification division.
       class-id. file-item.

       object.
           working-storage section.
           01 the-name pic x(20).
           01 the-size pic 9(4).

           procedure division.

           method-id. init.
               linkage section.
               01 name-in pic x(20).
               01 size-in pic 9(4).
               procedure division using name-in size-in.
                   move name-in to the-name
                   move size-in to the-size
               end method init.

           method-id. get-size.
               procedure division returning result as pic 9(4).
                   move the-size to result
               end method get-size.

           method-id. print.
               linkage section.
               01 indent pic x(10).
               procedure division using indent.
                   display function trim(indent, trailing)
                       function trim(the-name) " (" the-size "KB)"
               end method print.

       end object.
       end class file-item.

      *> ------------------------------------------------------------------
       identification division.
       class-id. folder.

       object.
           working-storage section.
           01 the-name     pic x(20).
           01 child-count  pic 9(2) value 0.
           01 child-table.
               05 child-entry object reference occurs 20 times.
           01 i            pic 9(2).
           01 running-size pic 9(5).

           procedure division.

           method-id. init.
               linkage section.
               01 name-in pic x(20).
               procedure division using name-in.
                   move name-in to the-name
               end method init.

           method-id. add.
               linkage section.
               01 item object reference.
               procedure division using item.
                   add 1 to child-count
                   move item to child-entry(child-count)
               end method add.

      *> delegates to each child and sums the results — doesn't matter
      *> if a child is a file-item or another folder
           method-id. get-size.
               working-storage section.
               01 child-size pic 9(4).
               procedure division returning result as pic 9(4).
                   move 0 to running-size
                   perform varying i from 1 by 1 until i > child-count
                       invoke child-entry(i) "get-size" returning child-size
                       add child-size to running-size
                   end-perform
                   move running-size to result
               end method get-size.

           method-id. print.
               linkage section.
               01 indent pic x(10).
               working-storage section.
               01 total       pic 9(4).
               01 next-indent pic x(10).
               procedure division using indent.
                   invoke self "get-size" returning total
                   display function trim(indent, trailing)
                       function trim(the-name) "/ (" total "KB)"
                   string function trim(indent, trailing) delimited by size
                       "  " delimited by size
                       into next-indent
                   perform varying i from 1 by 1 until i > child-count
                       invoke child-entry(i) "print" using next-indent
                   end-perform
               end method print.

       end object.
       end class folder.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class file-item.
           class folder.

       data division.
       working-storage section.
       01 root    object reference.
       01 src     object reference.
       01 readme  object reference.
       01 main-rs object reference.
       01 utils-rs object reference.
       01 blank-indent pic x(10) value spaces.

       procedure division.
           invoke folder "new" returning root
           invoke root "init" using "project"

           invoke file-item "new" returning readme
           invoke readme "init" using "README.md" 2
           invoke root "add" using readme

           invoke folder "new" returning src
           invoke src "init" using "src"

           invoke file-item "new" returning main-rs
           invoke main-rs "init" using "main.cbl" 5
           invoke src "add" using main-rs

           invoke file-item "new" returning utils-rs
           invoke utils-rs "init" using "utils.cbl" 3
           invoke src "add" using utils-rs

           invoke root "add" using src

           invoke root "print" using blank-indent

           stop run.
       end program main.
