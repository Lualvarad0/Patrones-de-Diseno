      *> Mediator in Object-Oriented COBOL (GnuCOBOL).
      *> "user" objects never talk to each other directly — they only
      *> know "chat-room", which decides who gets each message.
      *> Compile with:  cobc -x -free mediator.cbl -o mediator
       >>SOURCE FORMAT FREE
       identification division.
       class-id. chat-room.

       object.
           working-storage section.
           01 user-count pic 9(2) value 0.
           01 user-table.
               05 user-entry object reference occurs 10 times.
           01 i pic 9(2).

           procedure division.

           method-id. register.
               linkage section.
               01 user-in object reference.
               procedure division using user-in.
                   add 1 to user-count
                   move user-in to user-entry(user-count)
               end method register.

           method-id. send-message.
               linkage section.
               01 sender  object reference.
               01 message pic x(40).
               working-storage section.
               01 sender-name pic x(10).
               procedure division using sender message.
                   invoke sender "get-name" returning sender-name
                   perform varying i from 1 by 1 until i > user-count
                       if user-entry(i) not = sender
                           invoke user-entry(i) "receive" using sender-name message
                       end-if
                   end-perform
               end method send-message.

       end object.
       end class chat-room.

      *> ------------------------------------------------------------------
       identification division.
       class-id. user.

       environment division.
       configuration section.
       repository.
           class chat-room.

       object.
           working-storage section.
           01 the-name     pic x(10).
           01 the-chatroom object reference.

           procedure division.

           method-id. init.
               linkage section.
               01 name-in     pic x(10).
               01 chatroom-in object reference.
               procedure division using name-in chatroom-in.
                   move name-in to the-name
                   move chatroom-in to the-chatroom
                   invoke the-chatroom "register" using self
               end method init.

           method-id. get-name.
               procedure division returning result as pic x(10).
                   move the-name to result
               end method get-name.

           method-id. send.
               linkage section.
               01 message pic x(40).
               procedure division using message.
                   invoke the-chatroom "send-message" using self message
               end method send.

           method-id. receive.
               linkage section.
               01 from    pic x(10).
               01 message pic x(40).
               procedure division using from message.
                   display function trim(the-name) " received from "
                       function trim(from) ": " function trim(message)
               end method receive.

       end object.
       end class user.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class chat-room.
           class user.

       data division.
       working-storage section.
       01 chat-room-obj object reference.
       01 alice object reference.
       01 bob   object reference.
       01 carol object reference.

       procedure division.
           invoke chat-room "new" returning chat-room-obj

           invoke user "new" returning alice
           invoke alice "init" using "Alice" chat-room-obj

           invoke user "new" returning bob
           invoke bob "init" using "Bob" chat-room-obj

           invoke user "new" returning carol
           invoke carol "init" using "Carol" chat-room-obj

           invoke alice "send" using "Hey everyone!"
      *> Bob and Carol receive it, Alice doesn't

           stop run.
       end program main.
