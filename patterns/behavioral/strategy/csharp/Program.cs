// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable class, so the context using it doesn't need a big
// if/else to pick behavior.
public interface IPaymentStrategy
{
    void Pay(double amount);
}

public class CreditCardPayment : IPaymentStrategy
{
    public void Pay(double amount) => Console.WriteLine($"Paid ${amount} with credit card");
}

public class PayPalPayment : IPaymentStrategy
{
    public void Pay(double amount) => Console.WriteLine($"Paid ${amount} with PayPal");
}

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
public class ShoppingCart
{
    private IPaymentStrategy _paymentStrategy;

    public ShoppingCart(IPaymentStrategy paymentStrategy) => _paymentStrategy = paymentStrategy;

    public void SetPaymentStrategy(IPaymentStrategy paymentStrategy) => _paymentStrategy = paymentStrategy;

    public void Checkout(double amount) => _paymentStrategy.Pay(amount);
}

class Program
{
    static void Main()
    {
        var cart = new ShoppingCart(new CreditCardPayment());
        cart.Checkout(50.0);

        cart.SetPaymentStrategy(new PayPalPayment()); // swap strategy at runtime
        cart.Checkout(30.0);
    }
}
