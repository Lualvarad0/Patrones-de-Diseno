// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable class, so the context using it doesn't need a big
// if/else to pick behavior.
interface PaymentStrategy {
    void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy {
    public void pay(double amount) { System.out.println("Paid $" + amount + " with credit card"); }
}

class PayPalPayment implements PaymentStrategy {
    public void pay(double amount) { System.out.println("Paid $" + amount + " with PayPal"); }
}

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
class ShoppingCart {
    private PaymentStrategy paymentStrategy;

    ShoppingCart(PaymentStrategy paymentStrategy) { this.paymentStrategy = paymentStrategy; }

    void setPaymentStrategy(PaymentStrategy paymentStrategy) { this.paymentStrategy = paymentStrategy; }

    void checkout(double amount) { paymentStrategy.pay(amount); }
}

public class StrategyDemo {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart(new CreditCardPayment());
        cart.checkout(50.0);

        cart.setPaymentStrategy(new PayPalPayment()); // swap strategy at runtime
        cart.checkout(30.0);
    }
}
