      *> Strategy in Object-Oriented COBOL (GnuCOBOL).
      *> "shopping-cart" holds a payment strategy object reference and
      *> delegates "checkout" to whatever strategy it currently has —
      *> swappable at runtime with "set-payment-strategy".
      *> Compile with:  cobc -x -free strategy.cbl -o strategy
       >>SOURCE FORMAT FREE
       identification division.
       class-id. credit-card-payment.

       object.
           procedure division.

           method-id. pay.
               linkage section.
               01 amount pic 9(5)v99.
               procedure division using amount.
                   display "Paid $" amount " with credit card"
               end method pay.

       end object.
       end class credit-card-payment.

      *> ------------------------------------------------------------------
       identification division.
       class-id. paypal-payment.

       object.
           procedure division.

           method-id. pay.
               linkage section.
               01 amount pic 9(5)v99.
               procedure division using amount.
                   display "Paid $" amount " with PayPal"
               end method pay.

       end object.
       end class paypal-payment.

      *> ------------------------------------------------------------------
       identification division.
       class-id. shopping-cart.

       object.
           working-storage section.
           01 payment-strategy object reference.

           procedure division.

           method-id. set-payment-strategy.
               linkage section.
               01 strategy object reference.
               procedure division using strategy.
                   move strategy to payment-strategy
               end method set-payment-strategy.

           method-id. checkout.
               linkage section.
               01 amount pic 9(5)v99.
               procedure division using amount.
                   invoke payment-strategy "pay" using amount
               end method checkout.

       end object.
       end class shopping-cart.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class credit-card-payment.
           class paypal-payment.
           class shopping-cart.

       data division.
       working-storage section.
       01 cart       object reference.
       01 credit-pay object reference.
       01 paypal-pay object reference.

       procedure division.
           invoke credit-card-payment "new" returning credit-pay
           invoke paypal-payment "new" returning paypal-pay

           invoke shopping-cart "new" returning cart
           invoke cart "set-payment-strategy" using credit-pay
           invoke cart "checkout" using 50.00

           invoke cart "set-payment-strategy" using paypal-pay
           invoke cart "checkout" using 30.00

           stop run.
       end program main.
