      *> Iterator in Object-Oriented COBOL (GnuCOBOL).
      *> "book-iterator" walks through "book-collection" one title at a
      *> time via "has-next"/"next", without the caller ever touching
      *> the collection's internal table directly.
      *> Compile with:  cobc -x -free iterator.cbl -o iterator
       >>SOURCE FORMAT FREE
       identification division.
       class-id. book-collection.

       environment division.
       configuration section.
       repository.
           class book-iterator.

       object.
           working-storage section.
           01 book-count pic 9(2) value 0.
           01 book-table.
               05 book-entry pic x(30) occurs 20 times.

           procedure division.

           method-id. add.
               linkage section.
               01 title-in pic x(30).
               procedure division using title-in.
                   add 1 to book-count
                   move title-in to book-entry(book-count)
               end method add.

           method-id. get-count.
               procedure division returning result as pic 9(2).
                   move book-count to result
               end method get-count.

           method-id. get-book.
               linkage section.
               01 index-in pic 9(2).
               procedure division using index-in returning result as pic x(30).
                   move book-entry(index-in) to result
               end method get-book.

           method-id. create-iterator.
               working-storage section.
               01 iter object reference.
               procedure division returning result as object reference.
                   invoke book-iterator "new" returning iter
                   invoke iter "init" using self
                   move iter to result
               end method create-iterator.

       end object.
       end class book-collection.

      *> ------------------------------------------------------------------
       identification division.
       class-id. book-iterator.

       object.
           working-storage section.
           01 the-collection object reference.
           01 position       pic 9(2) value 0.

           procedure division.

           method-id. init.
               linkage section.
               01 collection-in object reference.
               procedure division using collection-in.
                   move collection-in to the-collection
               end method init.

           method-id. has-next.
               working-storage section.
               01 total pic 9(2).
               procedure division returning result as pic 9.
                   invoke the-collection "get-count" returning total
                   if position < total
                       move 1 to result
                   else
                       move 0 to result
                   end-if
               end method has-next.

           method-id. next.
               procedure division returning result as pic x(30).
                   add 1 to position
                   invoke the-collection "get-book" using position returning result
               end method next.

       end object.
       end class book-iterator.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class book-collection.

       data division.
       working-storage section.
       01 collection object reference.
       01 iterator   object reference.
       01 has-next-flag pic 9.
       01 title      pic x(30).

       procedure division.
           invoke book-collection "new" returning collection
           invoke collection "add" using "Clean Code"
           invoke collection "add" using "The Pragmatic Programmer"
           invoke collection "add" using "Design Patterns"

           invoke collection "create-iterator" returning iterator

           invoke iterator "has-next" returning has-next-flag
           perform until has-next-flag = 0
               invoke iterator "next" returning title
               display function trim(title)
               invoke iterator "has-next" returning has-next-flag
           end-perform

           stop run.
       end program main.
