// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable type implementing a trait, so the context using it
// doesn't need a big match/if-else to pick behavior.
trait PaymentStrategy {
    fn pay(&self, amount: f64);
}

struct CreditCardPayment;
impl PaymentStrategy for CreditCardPayment {
    fn pay(&self, amount: f64) {
        println!("Paid ${amount} with credit card");
    }
}

struct PayPalPayment;
impl PaymentStrategy for PayPalPayment {
    fn pay(&self, amount: f64) {
        println!("Paid ${amount} with PayPal");
    }
}

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
struct ShoppingCart {
    payment_strategy: Box<dyn PaymentStrategy>,
}

impl ShoppingCart {
    fn new(payment_strategy: Box<dyn PaymentStrategy>) -> Self {
        ShoppingCart { payment_strategy }
    }

    fn set_payment_strategy(&mut self, payment_strategy: Box<dyn PaymentStrategy>) {
        self.payment_strategy = payment_strategy;
    }

    fn checkout(&self, amount: f64) {
        self.payment_strategy.pay(amount);
    }
}

fn main() {
    let mut cart = ShoppingCart::new(Box::new(CreditCardPayment));
    cart.checkout(50.0);

    cart.set_payment_strategy(Box::new(PayPalPayment)); // swap strategy at runtime
    cart.checkout(30.0);
}
