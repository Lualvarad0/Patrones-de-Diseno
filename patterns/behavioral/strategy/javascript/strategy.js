// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable object/function, so the context using it doesn't need
// a big if/else to pick behavior.
class CreditCardPayment {
  pay(amount) {
    console.log(`Paid $${amount} with credit card`);
  }
}

class PayPalPayment {
  pay(amount) {
    console.log(`Paid $${amount} with PayPal`);
  }
}

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
class ShoppingCart {
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  setPaymentStrategy(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  checkout(amount) {
    this.paymentStrategy.pay(amount);
  }
}

// --- demo ---
const cart = new ShoppingCart(new CreditCardPayment());
cart.checkout(50.0);

cart.setPaymentStrategy(new PayPalPayment()); // swap strategy at runtime
cart.checkout(30.0);
