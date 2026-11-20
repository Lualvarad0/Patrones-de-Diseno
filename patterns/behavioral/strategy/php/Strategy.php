<?php
// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable class, so the context using it doesn't need a big
// if/else to pick behavior.
interface PaymentStrategy
{
    public function pay(float $amount): void;
}

class CreditCardPayment implements PaymentStrategy
{
    public function pay(float $amount): void
    {
        echo "Paid \${$amount} with credit card\n";
    }
}

class PayPalPayment implements PaymentStrategy
{
    public function pay(float $amount): void
    {
        echo "Paid \${$amount} with PayPal\n";
    }
}

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
class ShoppingCart
{
    public function __construct(private PaymentStrategy $paymentStrategy) {}

    public function setPaymentStrategy(PaymentStrategy $paymentStrategy): void
    {
        $this->paymentStrategy = $paymentStrategy;
    }

    public function checkout(float $amount): void
    {
        $this->paymentStrategy->pay($amount);
    }
}

// --- demo ---
$cart = new ShoppingCart(new CreditCardPayment());
$cart->checkout(50.0);

$cart->setPaymentStrategy(new PayPalPayment()); // swap strategy at runtime
$cart->checkout(30.0);
